# -*- coding: utf-8 -*-
require 'spec_helper'

describe TicketsController do
  let!(:user) { create :user }
  let!(:event) { create :event }

  before { session[:user_id] = user.id }

  describe 'GET #new' do
    it 'error404を render していること' do
      get :new, event_id: event.id
      expect(response).to render_template('error404')
    end
  end

  describe 'POST #create' do
    context 'パラメータが正しいとき' do
      it '200が返ること' do
        post :create, event_id: event.id, ticket: { comment: 'コメント' }
        expect(response.status).to eq(200)
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

  describe 'DELETE #destroy' do
    let!(:ticket) { create :ticket, user: user, event: event }

    it 'Ticketレコードの件数が1件減っていること' do
      expect { delete :destroy, event_id: event.id, id: ticket.id }.
        to change { Ticket.count }.by(-1)
    end

    it 'リクエストしたeventのshowアクションにリダイレクトすること' do
      delete :destroy, event_id: event.id, id: ticket.id
      expect(response).to redirect_to(event)
    end
  end
end
