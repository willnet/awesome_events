# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner
    name 'we-love-rails'
    place '東京都のどこか'
    content '楽しくRailsを学びます'
    start_time { rand(1..30).days.from_now }
    end_time { start_time + rand(1..30).hours }
  end
end
