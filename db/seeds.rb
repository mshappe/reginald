# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times.each do
  fake_event_id = 42
  fake_event_name = "THIS IS A FAKE"
  FactoryBot.create :attendee, event_id: fake_event_id, event_name: fake_event_name
end

user = User.create(email: 'squid@squid.co', password: 'llamaface', password_confirmation: 'llamaface')
user.confirm
user.add_role(:admin)
