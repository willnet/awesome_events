# -*- coding: utf-8 -*-
require 'spec_helper'

describe SessionsController do
  describe 'GET #create' do
    context 'User.find_or_create_from_auth_hash が id: 1 のオブジェクトを返すとき' do

      before do
        allow(User).to receive(:find_or_create_from_auth_hash) { double('user', id: 1) }
        get :create, provider: 'twitter'
      end


      it 'session[:user_id] に 1 が格納されること' do
        expect(session[:user_id]).to eq 1
      end

      it 'トップページにリダイレクトすること' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #destroy' do
    context 'session[:user_id] に 1 が格納されているとき' do
      before do
        session[:user_id] = 1
        get :destroy
      end

      it 'session[:user_id] が nil であること' do
        expect(session[:user_id]).to be_nil
      end

      it 'トップページにリダイレクトすること' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
