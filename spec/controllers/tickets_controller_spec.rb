# -*- coding: utf-8 -*-
require 'spec_helper'

describe TicketsController do
  let!(:event) { create :event }

  describe 'GET #new' do
    context '未ログインユーザがアクセスしたとき' do
      before { get :new, event_id: event.id }

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      let!(:user) { create :user }

      before do
        login(user)
        get :new, event_id: event.id
      end

      it 'error404を render していること' do
        expect(response).to render_template('error404')
      end
    end
  end

  describe 'POST #create' do
    context '未ログインユーザがアクセスしたとき' do
      before { post :create, event_id: event.id, ticket: { comment: 'コメント' } }

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      let!(:user) { create :user }

      before { login(user) }

      context 'パラメータが正しいとき' do
        it 'ステータスコードとして201が返ること' do
          post :create, event_id: event.id, ticket: { comment: 'コメント' }
          expect(response.status).to eq(201)
        end

        it 'Ticketレコードが1件増えること' do
          expect { post :create, event_id: event.id, ticket: attributes_for(:ticket, user: user, event: event) }.
            to change { Ticket.count }.by(1)
        end
      end

      context 'パラメータが不正なとき' do
        it '422が返ること' do
          post :create, event_id: event.id, ticket: attributes_for(:invalid_ticket, user: user, event: event)
          expect(response.status).to eq(422)
        end

        it 'Ticketレコードの件数に変化がないこと' do
          expect { post :create, event_id: event.id, ticket: { comment: 'コメント' * 10 } }.
            not_to change { Ticket.count }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:owner) { create :user }
    let!(:ticket) { create :ticket, user: owner, event: event }

    context '未ログインユーザがアクセスしたとき' do
      before { delete :destroy, event_id: event.id, id: ticket.id }

      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつ参加表明に紐付いているユーザがアクセスしたとき' do
      before { login(owner) }

      it 'Ticketレコードの件数が1件減っていること' do
        expect { delete :destroy, event_id: event.id, id: ticket.id }.
          to change { Ticket.count }.by(-1)
      end

      it 'リクエストしたeventのshowアクションにリダイレクトすること' do
        delete :destroy, event_id: event.id, id: ticket.id
        expect(response).to redirect_to(event)
      end
    end

    context 'ログインユーザかつ参加表明に紐付いていないユーザがアクセスしたとき' do
      let!(:not_owner) { create :user }

      before { login(not_owner) }

      it 'Ticketレコードの件数が減っていないこと' do
        expect { delete :destroy, event_id: event.id, id: ticket.id }.
          not_to change { Ticket.count }
      end

      it 'error404テンプレートをrenderしていること' do
        delete :destroy, event_id: event.id, id: ticket.id
        expect(response).to render_template :error404
      end
    end
  end
end
