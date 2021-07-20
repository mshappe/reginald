FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'splungeitude' }
    password_confirmation { 'splungeitude' }

    trait :when_confirmed do
      after :create do |thing|
        thing.confirm
      end
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
  end
end
