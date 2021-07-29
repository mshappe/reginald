# frozen_string_literal: true

# == Schema Information
#
# Table name: attendee_notes
#
#  id          :bigint           not null, primary key
#  note        :text
#  note_type   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_attendee_notes_on_attendee_id  (attendee_id)
#  index_attendee_notes_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :attendee_note do
    note { Faker::Lorem.paragraph }
    note_type { :general }
    association :attendee
  end
end
