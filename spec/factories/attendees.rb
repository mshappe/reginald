FactoryBot.define do
  factory :attendee do
    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    area_code { Faker::PhoneNumber.area_code }
    phone_number { Faker::PhoneNumber.phone_number }
    badge_name { Faker::Lorem.word }
    badge_number { Faker::Number.positive }
    email { Faker::Internet.email }
    event_name { Faker::Lorem.sentence }
    event_id { Faker::Number.positive }
    registrant_legal_name { Faker::Name.name }
    legal_name { Faker::Name.name }
    preferred_first_name { Faker::Name.first_name }
    preferred_last_name { Faker::Name.last_name }
  end
end
