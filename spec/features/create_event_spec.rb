# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'ユーザがイベント参加者を集めるために、イベントを作成する' do
  context '未ログインのユーザがトップページに遷移し、"イベントを作る"リンクをクリックしたとき' do
    before do
      visit root_path
      click_link "イベントを作る"
    end

    it '"ログインしてください"と表示されていること' do
      expect(page).to have_content('ログインしてください')
    end
  end

  context 'ログインユーザがトップページに遷移し、"イベントを作る"リンクをクリックしたとき' do
    before do
      login
      visit root_path
      click_link "イベントを作る"
    end

    it '"イベント作成"と表示されていること' do
      expect(page).to have_content 'イベント作成'
    end

    context 'かつ、各入力項目を正しく埋めて"作成"ボタンをクリックしたとき' do
      before do
        now = Time.zone.now
        start_time = 1.day.from_now(now)
        end_time = 2.day.from_now(now)

        fill_in '名前', with: 'Rails勉強会'
        fill_in '場所', with: '都内某所'
        select start_time.year, from: 'event_start_time_1i'
        select "#{start_time.month}月", from: 'event_start_time_2i'
        select start_time.day, from: 'event_start_time_3i'
        select end_time.year, from: 'event_end_time_1i'
        select "#{end_time.month}月", from: 'event_end_time_2i'
        select end_time.day, from: 'event_end_time_3i'
        attach_file('event_event_image', './spec/event_image.png')
        fill_in '内容', with: 'みんなでRailsを勉強します'

        click_button '作成'
      end

      it '"作成しました"と表示されていること' do
        expect(page).to have_content '作成しました'
      end

      it 'イベント名が表示されていること' do
        expect(page).to have_content 'Rails勉強会'
      end
    end

    context 'かつ、入力内容に不備がある状態で"作成"ボタンをクリックしたとき' do
      before do
        click_button '作成'
      end

      it '"作成しました"と表示されていないこと' do
        expect(page).to have_no_content('作成しました')
      end

      it 'なんらかのエラー表示がされていること' do
        expect(page).to have_css('.alert.alert-danger')
      end
    end
  end
end
