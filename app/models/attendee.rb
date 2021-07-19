# == Schema Information
#
# Table name: attendees
#
#  id                    :integer          not null, primary key
#  aasm_state            :string
#  address1              :string
#  address2              :string
#  area_code             :string
#  badge_name            :string
#  badge_number          :integer
#  city                  :string
#  country               :string
#  email                 :string
#  emergency_contact     :string
#  event_name            :string
#  guest_badge           :boolean
#  legal_name            :string
#  membership_type       :string
#  phone_number          :string
#  preferred_first_name  :string
#  preferred_last_name   :string
#  registrant_legal_name :string
#  state                 :string
#  zip                   :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  event_id              :integer
#  registrant_id         :integer
#
# Indexes
#
#  index_attendees_on_badge_name    (badge_name)
#  index_attendees_on_badge_number  (badge_number)
#  index_attendees_on_event_id      (event_id)
#
class Attendee < ApplicationRecord
  include AASM

  aasm do
    state :absent, initial: true, display: "Not Checked In"
    state :checked_in, display: 'Checked In'
    state :reissued_once, display: 'Checked In (1st Reissue)'
    state :reissued_twice, display: 'Checked In (2nd Reissue)'
    state :reissued_thrice, display: 'Checked In (3rd Reissue)'
    state :last_chance, display: 'Checked In (4th Reissue)'
    state :ejected, display: 'Ejected'

    event :checkin do
      transitions from: :absent, to: :checked_in
    end

    event :uncheckin do
      transitions from: :checked_in, to: :absent
    end

    event :reissue do
      transitions from: :checked_in, to: :reissued_once
      transitions from: :reissued_once, to: :reissued_twice
      transitions from: :reissued_twice, to: :reissued_thrice
      transitions from: :reissued_thrice, to: :last_chance
    end

    event :eject do
      transitions to: :ejected
    end
  end


end
