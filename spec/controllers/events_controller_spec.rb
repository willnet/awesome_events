# -*- coding: utf-8 -*-
require 'spec_helper'

describe EventsController do
  describe 'GET #show' do
    let!(:event) { create :event }
    let!(:bob) { create :user, nickname: 'bob' }
    let!(:alice) { create :user, nickname: 'alice' }
    let!(:ticket_bob) { create :ticket, event: event, user: bob }
    let!(:ticket_alice) { create :ticket, event: event, user: alice }

    context 'イベントに参加表明していないユーザがアクセスしたとき' do
      before { get :show, id: event.id }

      it '@event に、リクエストした Event オブジェクトが格納されていること' do
        expect(assigns(:event)).to eq(event)
      end

      it '@ticket に、nil が格納されていること' do
        expect(assigns(:ticket)).to be_nil
      end

      it '@tickets に、イベント参加表明者のTicketオブジェクトが格納されていること' do
        expect(assigns(:tickets)).to match_array([ticket_bob, ticket_alice])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end

    context 'イベントに参加表明しているログインユーザがアクセスしたとき' do
      before do
        login(bob)
        get :show, id: event.id
      end

      it '@event に、リクエストした Event オブジェクトが格納されていること' do
        expect(assigns(:event)).to eq(event)
      end

      it '@ticket に、アクセスしたユーザのTicketオブジェクトが格納されていること' do
        expect(assigns(:ticket)).to eq(ticket_bob)
      end

      it '@tickets に、イベント参加表明者のTicketオブジェクトが格納されていること' do
        expect(assigns(:tickets)).to match_array([ticket_bob, ticket_alice])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    context '未ログインユーザがアクセスしたとき' do
      before { get :new }

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      before do
        user = create :user
        login(user)
        get :new
      end

      it 'ステータスコードとして200が返ること' do
        expect(response.status).to eq(200)
      end

      it '@eventに、新規Eventオブジェクトが格納されていること' do
        expect(assigns(:event)).to be_a_new(Event)
      end

      it 'newテンプレートをrenderしていること' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    context '未ログインユーザがアクセスしたとき' do
      before { post :create, event: attributes_for(:event) }

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      let!(:bob) { create :user, nickname: 'bob' }
      before { login(bob) }

      context 'パラメータが正しいとき' do
        it 'Eventレコードが1件増えること' do
          expect { post :create, event: attributes_for(:event) }.
            to change { Event.count }.by(1)
        end

        it '@eventのshowアクションにリダイレクトすること' do
          post :create, event: attributes_for(:event)
          expect(response).to redirect_to(event_path(assigns[:event]))
        end
      end

      context 'パラメータが不正なとき' do
        it 'Eventレコードの件数に変化がないこと' do
          expect { post :create, event: attributes_for(:invalid_event) }.
            not_to change { Event.count }
        end

        it 'newテンプレートをrenderしていること' do
          post :create, event: attributes_for(:invalid_event)
          expect(response).to render_template :new
        end
      end

    end
  end

  describe 'GET #edit' do
    let!(:owner) { create :user }
    let!(:event) { create :event, owner: owner }

    context '未ログインユーザがアクセスしたとき' do
      before { get :edit, id: event.id }

      it_should_behave_like '認証が必要なページ'
    end


    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before do
        login(owner)
        get :edit, id: event.id
      end

      it '@eventに、リクエストしたEventオブジェクトが格納されていること' do
        expect(assigns(:event)).to eq(event)
      end

      it 'editテンプレートをrenderしていること' do
        expect(response).to render_template :edit
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:not_owner) { create :user }

      before do
        login(not_owner)
        get :edit, id: event.id
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end

  describe 'PATCH #update' do
    let!(:owner) { create :user }
    let!(:event) { create :event, owner: owner }

    context '未ログインユーザがアクセスしたとき' do
      before do
        patch :update, id: event.id, event: attributes_for(:event)
      end

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before { login(owner) }

      context 'かつパラメータが正しいとき' do
        before do
          patch :update, id: event.id, event: attributes_for(:event, name: 'Rails勉強会', place: '都内某所', content: 'Railsを勉強しよう', start_time: Time.zone.local(2014, 1, 1, 10, 0), end_time: Time.zone.local(2014, 1, 1, 19, 0))
        end

        it 'Eventレコードが正しく変更されていること' do
          event.reload
          expect(event.name).to eq('Rails勉強会')
          expect(event.place).to eq('都内某所')
          expect(event.content).to eq('Railsを勉強しよう')
          expect(event.start_time).to eq(Time.zone.local(2014, 1, 1, 10, 0))
          expect(event.end_time).to eq(Time.zone.local(2014, 1, 1, 19, 0))
        end

        it '@eventのshowアクションにリダイレクトすること' do
          expect(response).to redirect_to(event_path(assigns[:event]))
        end
      end

      context 'かつパラメータが不正なとき' do
        it 'Eventレコードが変更されていないこと' do
          expect { patch :update, id: event.id, event: attributes_for(:event, name: '', place: '都内某所', content: 'Railsを勉強しよう', start_time: Time.zone.local(2014, 1, 1, 10, 0), end_time: Time.zone.local(2014, 1, 1, 19, 0)) }.not_to change { event.reload } 
        end

        it 'editテンプレートをrenderしていること' do
          patch :update, id: event.id, event: attributes_for(:event, name: '', place: '都内某所', content: 'Railsを勉強しよう', start_time: Time.zone.local(2014, 1, 1, 10, 0), end_time: Time.zone.local(2014, 1, 1, 19, 0))
          expect(response).to render_template :edit
        end
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:not_owner) { create :user }

      before do
        login(not_owner)
        patch :update, id: event.id, event: attributes_for(:event)
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:owner) { create :user }
    let!(:event) { create :event, owner: owner }

    context '未ログインユーザがアクセスしたとき' do
      before { delete :destroy, id: event.id }

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがクセスしたとき' do
      before { login(owner) }

      it 'Eventレコードが1件減っていること' do
        expect { delete :destroy, id: event.id }.
          to change { Event.count }.by(-1)
      end

      it 'トップページにリダイレクトすること' do
        delete :destroy, id: event.id
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがクセスしたとき' do
      let!(:not_owner) { create :user }
      before { login(not_owner) }

      it 'Eventレコードが減っていないこと' do
        expect { delete :destroy, id: event.id }.
          not_to change { Event.count }
      end

      it 'error404テンプレートをrenderしていること' do
        delete :destroy, id: event.id
        expect(response).to render_template :error404
      end
    end
  end
end
