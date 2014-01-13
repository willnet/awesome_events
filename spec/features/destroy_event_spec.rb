# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'ユーザが作成したイベントを削除する' do
  let!(:user) { create :user, uid: '12345' }
  let!(:own_event) { create :event, owner: user }
  let!(:other_event) { create :event }

  context '未ログインのユーザがイベント詳細ページに遷移したとき' do
    before { visit event_path(other_event) }

    it '"イベントを削除する"リンクが表示されていないこと' do
      expect(page).to have_no_link('イベントを削除する')
    end
  end

  context 'ログインユーザが、他人が作成したイベント詳細ページに遷移したとき' do
    before do
      login
      visit event_path(other_event)
    end

    it '"イベントを削除する"リンクが表示されていないこと' do
      expect(page).to have_no_link('イベントを削除する')
    end
  end

  context 'ログインユーザが、自分が作成したイベント詳細ページに遷移したとき' do
    before do
      login
      visit event_path(own_event)
    end

    it '"イベントを削除する"リンクが表示されていること' do
      expect(page).to have_link('イベントを削除する')
    end

    context 'かつ"イベントを削除する"リンクをクリックし、ダイアログで"OK"をクリックしたとき', js: true do
      before do
        click_link 'イベントを削除する'
      end

      it '"削除しました"と表示されていること' do
        expect(page).to have_content('削除しました')
      end

      it 'トップページに遷移していること' do
        expect(page.current_path).to eq root_path
      end

      it '削除したイベント名が表示されていないこと' do
        expect(page).to have_no_content(own_event.name)
      end
    end

    context 'かつ"イベントを削除する"リンクをクリックし、ダイアログで"キャンセル"をクリックしたとき', js: true do
      before do
        page.evaluate_script('window.confirm = function() { return false; }')
        click_link 'イベントを削除する'
      end

      it '"削除しました"と表示されていないこと' do
        expect(page).to have_no_content('削除しました')
      end

      it 'イベント詳細ページにいること' do
        expect(page.current_path).to eq event_path(own_event)
      end
    end
  end
end
