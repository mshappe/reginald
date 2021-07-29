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
require 'rails_helper'

RSpec.describe AttendeeNote, type: :model do
  it { is_expected.to belong_to :attendee }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :note }
  it { is_expected.to validate_length_of(:note).is_at_least(10).is_at_most(2048) }
  it { is_expected.to validate_presence_of :note_type }
  it { is_expected.to validate_inclusion_of(:note_type).in_array(AttendeeNote::NOTE_TYPES) }
end
