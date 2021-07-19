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
  end
end
