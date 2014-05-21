# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  it { should have_many(:created_events).with_foreign_key(:owner_id).dependent(:nullify) }
  it { should have_many(:tickets).dependent(:nullify) }
  it { should have_many(:participating_events).source(:event).through(:tickets) }

  describe '.find_or_create_from_auth_hash' do
    let(:auth_hash) do
      {
        provider: 'twitter',
        uid: 'uid',
        info: {
          nickname: 'netwillnet',
          image: 'http://example.com/netwillnet.jpg'
        }
      }
    end
    
    context '引数のproviderとuidに対応するUserが作成されていないとき' do
      it '引数で設定した属性のUserオブジェクトが返ること' do
        user = User.find_or_create_from_auth_hash(auth_hash)
        expect(user.provider).to eq 'twitter'
        expect(user.uid).to eq 'uid'
        expect(user.nickname).to eq 'netwillnet'
        expect(user.image_url).to eq 'http://example.com/netwillnet.jpg'
        expect(user).to be_persisted
      end

      it 'Userモデルのレコードが一件増えていること' do
        expect { User.find_or_create_from_auth_hash(auth_hash) }.
          to change { User.count }.from(0).to(1)
      end
    end

    context '引数のproviderとuidに対応するUserが作成されているとき' do
      let!(:created_user) { create :user, provider: 'twitter', uid: 'uid' }

      it '引数に対応するUserレコードのオブジェクトが返ること' do
        user = User.find_or_create_from_auth_hash(auth_hash)
        expect(user).to eq created_user
      end

      it 'Userモデルのレコード件数が変化していないこと' do
        expect { User.find_or_create_from_auth_hash(auth_hash) }.
          not_to change { User.count }
      end
    end
  end

  describe '#check_all_events_finished' do
    let(:user) { create :user }

    context 'ユーザに関連する公開中の未終了イベント、未終了の参加イベントともに存在していないとき' do
      before do
        event = create :event, owner: user, start_time: 2.day.ago, end_time: 1.day.ago
        create :ticket, user: user, event: event
      end

      it 'true が返ること' do
        expect(user.send(:check_all_events_finished)).to eq true
      end

      it '#errorsが空なこと' do
        user.send(:check_all_events_finished)
        expect(user.errors).to be_empty
      end
    end

    context '公開中の未終了イベントが存在するとき' do
      before do
        create :event, owner: user, start_time: 1.day.ago, end_time: 1.day.from_now
      end

      it 'false が返ること' do
        expect(user.send(:check_all_events_finished)).to eq false
      end

      it '#errors[:base] に "公開中の未終了イベントが存在します。" が格納されていること' do
        user.send(:check_all_events_finished)
        expect(user.errors[:base]).to be_include('公開中の未終了イベントが存在します。')
      end
    end

    context '未終了の参加イベントが存在するとき' do
      before do
        event = create :event, owner: user, start_time: 1.day.ago, end_time: 1.day.from_now
        create :ticket, user: user, event: event
      end

      it 'false が返ること' do
        expect(user.send(:check_all_events_finished)).to eq false
      end

      it '#errors[:base] に "未終了の参加イベントが存在します。" が格納されていること' do
        user.send(:check_all_events_finished)
        expect(user.errors[:base]).to be_include('未終了の参加イベントが存在します。')
      end
    end
  end
end
