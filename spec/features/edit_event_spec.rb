# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'ユーザが作成したイベント情報に修正を加える' do
  let!(:user) { create :user, uid: '12345' }
  let!(:own_event) { create :event, owner: user }
  let!(:other_event) { create :event }

  context '未ログインのユーザがイベント詳細ページに遷移したとき' do
    before { visit event_path(other_event) }
    
    it '"イベントを編集する"リンクが表示されていないこと' do
      expect(page).to have_no_link('イベントを編集する')
    end
  end

  context '未ログインのユーザがイベント編集ページに遷移したとき' do
    before { visit edit_event_path(other_event) }

    it '"ログインしてください"と表示されていること' do
      expect(page).to have_content('ログインしてください')
    end
  end

  context 'ログインユーザが、他人が作成したイベント詳細ページに遷移したとき' do
    before do
      login
      visit event_path(other_event)
    end

    it '"イベントを編集する"リンクが表示されていないこと' do
      expect(page).to have_no_link('イベントを編集する')
    end
  end

  context 'ログインユーザが、他人が作成したイベント詳細ページに遷移したとき' do
    before do
      login
      visit edit_event_path(other_event)
    end

    it '"ご指定になったページは存在しません"と表示されていること' do
      expect(page).to have_no_link('ご指定になったページは存在しません')
    end
  end

  context 'ログインユーザが、自分が作成したイベント詳細ページに遷移したとき' do
    before do
      login
      visit event_path(own_event)
    end
    
    it '"イベントを編集する"リンクが表示されていること' do
      expect(page).to have_link('イベントを編集する')
    end

    context 'かつ"イベントを編集する"リンクをクリックしたとき' do
      before { click_link 'イベントを編集する' }

      it '"イベント情報編集"と表示されていること' do
        expect(page).to have_content 'イベント情報編集'
      end

      context 'かつ、正しく編集し"更新"ボタンをクリックしたとき' do
        before do
          fill_in '名前', with: 'Rails勉強会'
          click_button '更新'
        end

        it '"更新しました"と表示されていること' do
          expect(page).to have_content '更新しました'
        end

        it '編集した項目が表示されていること' do
          expect(page).to have_content 'Rails勉強会'
        end
      end

      context 'かつ、編集内容に不備がある状態で"更新"ボタンをクリックしたとき' do
        before do
          fill_in '名前', with: ''
          click_button '更新'
        end

        it '"更新しました"と表示されていないこと' do
          expect(page).to have_no_content '更新しました'
        end

        it 'なんらかのエラー表示がされていること' do
          expect(page).to have_css('.alert.alert-danger')
        end
      end
    end
  end
end
