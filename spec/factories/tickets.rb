# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    user
    event
    sequence(:comment) { |i| "コメント#{i}" }

    factory :invalid_ticket do
      comment { 'a' * 100 }
    end
  end
end
