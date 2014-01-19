# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner
    sequence(:name) { |i| "イベント名#{i}" }
    sequence(:place) { |i| "イベント開催場所#{i}" }
    sequence(:content) { |i| "イベント本文#{i}" }
    start_time { rand(1..30).days.from_now }
    end_time { start_time + rand(1..30).hours }

    factory :invalid_event do
      name { nil }
    end
  end
end
