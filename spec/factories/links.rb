# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url Faker::Internet.url
    title Faker::Lorem.word
    body Faker::Lorem.paragraph
  end
end