# -*- coding: utf-8 -*-
require 'spec_helper'

describe ApplicationController do
  controller do
    before_action :authenticate, only: :require_login

    def runtime_error
      raise
    end

    def not_found_error
      raise ActiveRecord::RecordNotFound
    end

    def routing_error
      raise ActionController::RoutingError, 'routing error'
    end

    def require_login
      render text: 'hello!'
    end
  end

  context 'ActiveRecord::RecordNotFound を raise したとき' do
    before do
      routes.draw { get 'not_found_error' => "anonymous#not_found_error" }
    end

    it "error404 を表示すること" do
      get :not_found_error
      expect(response).to render_template('error404')
    end
  end

  context 'ActionController::RoutingError を raise したとき' do
    before do
      routes.draw { get 'routing_error' => "anonymous#routing_error" }
    end

    it "error404 を表示すること" do
      get :routing_error
      expect(response).to render_template('error404')
    end
  end

  context "RuntimeErrorをraiseしたとき" do
    before do
      routes.draw { get 'runtime_error' => "anonymous#runtime_error" }
    end

    it "error500 を表示すること" do
      get :runtime_error
      expect(response).to render_template('error500')
    end
  end

  context '#authenticate が before_action として設定されているアクションを実行したとき' do
    before do
      routes.draw { get 'require_login' => "anonymous#require_login" }
    end
    
    context 'かつログイン中なとき' do
      before { session[:user_id] = 1 }

      it 'ステータスコードとして200が返ること' do
        get :require_login
        expect(response.status).to eq(200)
      end
    end

    context 'かつ未ログイン中なとき' do
      it 'トップページにリダイレクトすること' do
        get :require_login
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
