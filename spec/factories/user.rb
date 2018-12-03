# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    trait :with_profile do
      profile
    end
  end
end
