# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'squid@squid.co', password: 'llamaface', password_confirmation: 'llamaface')
user.confirm
user.add_role(:admin)

users = FactoryBot.create_list :user, 10
users.each do |u|
  u.confirm
  u.add_role(:staff)
end

100.times.each do
  fake_event_id = 42
  fake_event_name = 'THIS IS A FAKE'
  a = FactoryBot.create :attendee, event_id: fake_event_id, event_name: fake_event_name
  FactoryBot.create(:attendee_note, attendee: a, user: User.all.sample) if rand(0..5) > 3
end
