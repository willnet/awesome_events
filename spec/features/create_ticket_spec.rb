# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'ユーザがイベント参加表明をする', js: true do
  let!(:event) { create :event }

  context '未ログインユーザが、イベント詳細ページで"参加する"をクリックしたとき' do
    before do
      visit event_path(event)
      click_on '参加する'
    end

    it '"ログインしてください"と表示されていること' do
      expect(page).to have_content('ログインしてください')
    end
  end

  context 'ログインユーザが、イベント詳細ページで"参加する"をクリックしたとき' do
    before do
      login
      visit event_path(event)
      click_on '参加する'
    end

    it 'コメント入力用のモーダルウィンドウが表示されていること' do
      expect(page.find('#createTicket')).to be_visible
    end

    context 'かつ、コメントを入力し"送信"ボタンをおしたとき' do
      before do
        fill_in 'ticket_comment', with: '参加します！'
        click_button '送信'
      end

      it '"このイベントに参加表明しました"と表示されていること' do
        expect(page).to have_content('このイベントに参加表明しました')
      end

      it '参加表明したユーザ名が表示されていること' do
        expect(page).to have_content('@netwillnet')
      end
    end

    context 'かつ、コメントに長文を入力し送信ボタンをおしたとき' do
      before do
        fill_in 'ticket_comment', with: '参加します！' * 100
        click_button '送信'
      end

      it '"このイベントに参加表明しました"と表示されていないこと' do
        expect(page).to have_no_content('このイベントに参加表明しました')
      end
      it 'なんらかのエラー表示がされていること' do
        expect(page).to have_css('.alert.alert-danger')
      end
    end
  end
end
