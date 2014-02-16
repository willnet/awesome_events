# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'ユーザがイベントの参加表明をキャンセルする' do
  let!(:user) { create :user, uid: '12345' }
  let!(:not_participating_event) { create :event }
  let!(:participating_event) { create :event }
  before { create :ticket, event: participating_event, user: user }

  context '未ログインのユーザがイベント詳細ページに遷移したとき' do
    before { visit event_path(not_participating_event) }
      
    it '"参加をキャンセルする"リンクが表示されていないこと' do
      expect(page).to have_no_content('参加をキャンセルする')
    end
  end

  context 'ログインユーザが、未参加のイベント詳細ページに遷移したとき' do
    before do
      login
      visit event_path(not_participating_event)
    end

    it '"参加をキャンセルする"リンクが表示されていないこと' do
      expect(page).to have_no_content('参加をキャンセルする')
    end
  end

  context 'ログインユーザが、参加表明済みのイベント詳細ページに遷移したとき' do
    before do
      login
      visit event_path(participating_event)
    end

    it 'ログインユーザの名前が表示されていること' do
      expect(page).to have_content(user.nickname)
    end

    it '"参加をキャンセルする"リンクが表示されていること' do
      expect(page).to have_content('参加をキャンセルする')
    end

    context 'かつ、"参加をキャンセルする"リンクをクリックしたとき' do
      before { click_link '参加をキャンセルする' }

      it '"このイベントの参加をキャンセルしました"と表示されていること' do
        expect(page).to have_content('このイベントの参加をキャンセルしました')
      end

      it 'ログインユーザの名前が表示されていないこと' do
        expect(page).to have_no_content(user.nickname)
      end
    end
  end
end
