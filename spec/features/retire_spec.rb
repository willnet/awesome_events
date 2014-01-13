# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'ユーザが退会処理をする' do
  context '未ログインユーザがトップページに遷移したとき' do
    before { visit root_path }

    it '"退会"リンクが表示されていないこと' do
      expect(page).to have_no_link('退会')
    end
  end

  context '未ログインユーザが退会ページに遷移したとき' do
    before { visit retire_user_path }

    it '"ログインしてください"と表示されていること' do
      expect(page).to have_content('ログインしてください')
    end
  end

  context 'ログインユーザがトップページに遷移したとき' do
    before do
      login
      visit root_path
    end

    it '"退会"リンクが表示されていること' do
      expect(page).to have_link('退会')
    end

    context 'かつ"退会"リンクをクリックしたとき' do
      before { click_link '退会' }

      it '"退会の確認"と表示されていること' do
        expect(page).to have_content('退会の確認')
      end

      context 'かつ"退会する"リンクをクリックしたとき', js: true do
        before { click_link '退会する' }

        it '"退会完了しました"と表示されていること' do
          expect(page).to have_content('退会完了しました')
        end

        it '"Twitterでログイン"リンクが表示されていること' do
          expect(page).to have_link('Twitterでログイン')
        end
      end
    end
  end
end
