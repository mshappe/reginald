# frozen_string_literal: true

# == Schema Information
#
# Table name: attendees
#
#  id                       :bigint           not null, primary key
#  aasm_state               :string
#  address1                 :string
#  address2                 :string
#  area_code                :string
#  badge_name               :string
#  business_name            :string
#  checked_in_at            :datetime
#  checked_in_by            :bigint
#  city                     :string
#  country                  :string
#  ejected_at               :datetime
#  ejected_by               :bigint
#  email                    :string
#  emergency_contact        :string
#  event_name               :string
#  guest_badge              :boolean
#  last_chance_at           :datetime
#  last_chance_by           :bigint
#  last_chance_pay_type     :string
#  legal_name               :string
#  membership_type          :string
#  phone_number             :string
#  preferred_first_name     :string
#  preferred_last_name      :string
#  registered_at            :datetime
#  registrant_legal_name    :string
#  reissued_once_at         :datetime
#  reissued_once_by         :bigint
#  reissued_thrice_at       :datetime
#  reissued_thrice_by       :bigint
#  reissued_thrice_pay_type :string
#  reissued_twice_at        :datetime
#  reissued_twice_by        :bigint
#  reissued_twice_pay_type  :string
#  state                    :string
#  zip                      :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  event_id                 :integer
#  neon_attendee_id         :integer
#  registrant_id            :integer
#  transaction_id           :integer
#
# Indexes
#
#  index_attendees_on_badge_name        (badge_name)
#  index_attendees_on_event_id          (event_id)
#  index_attendees_on_neon_attendee_id  (neon_attendee_id)
#
FactoryBot.define do
  factory :attendee do
    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    area_code { Faker::PhoneNumber.area_code }
    phone_number { Faker::PhoneNumber.phone_number }
    badge_name { Faker::Lorem.word }
    neon_attendee_id { Faker::Number.positive }
    email { Faker::Internet.email }
    event_name { Faker::Lorem.sentence }
    event_id { Faker::Number.positive }
    registrant_legal_name { Faker::Name.name }
    legal_name { Faker::Name.name }
    preferred_first_name { Faker::Name.first_name }
    preferred_last_name { Faker::Name.last_name }
    guest_badge { Faker::Boolean.boolean true_ratio: 0.1 }
    sequence(:transaction_id)
    registered_at { Faker::Date.between(from: 1.year.ago, to: 5.days.ago) }
  end
end
