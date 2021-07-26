# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'splungeitude' }
    password_confirmation { 'splungeitude' }

    trait :when_confirmed do
      after :create, &:confirm
    end

    trait :when_admin do
      after :create do |thing|
        thing.add_role :admin
      end
    end

    trait :when_head do
      after :create do |thing|
        thing.add_role :head
      end
    end

    trait :when_helpdesk do
      after :create do |thing|
        thing.add_role :helpdesk
      end
    end

    trait :when_staff do
      after :create do |thing|
        thing.add_role :staff
      end
    end

    trait :when_read_only do
      after :create do |thing|
        thing.add_role :read_only
      end
    end
  end
end
