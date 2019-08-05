# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title   { Faker::Book.title }
    content { Faker::Lorem.sentence }
  end
end
