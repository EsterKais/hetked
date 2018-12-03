# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    firstname { Faker::Artist.name }
    lastname { Faker::Artist.name }
    username { Faker::Artist.name }
    birthday { Faker::Date.between(25.years.ago, 18.years.ago) }
    user
  end
end
