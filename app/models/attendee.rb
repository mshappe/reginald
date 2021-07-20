# == Schema Information
#
# Table name: attendees
#
#  id                    :bigint           not null, primary key
#  aasm_state            :string
#  address1              :string
#  address2              :string
#  area_code             :string
#  badge_name            :string
#  badge_number          :integer
#  checked_in_at         :datetime
#  checked_in_by         :bigint
#  city                  :string
#  country               :string
#  ejected_at            :datetime
#  ejected_by            :bigint
#  email                 :string
#  emergency_contact     :string
#  event_name            :string
#  guest_badge           :boolean
#  last_chance_at        :datetime
#  last_chance_by        :bigint
#  legal_name            :string
#  membership_type       :string
#  phone_number          :string
#  preferred_first_name  :string
#  preferred_last_name   :string
#  registrant_legal_name :string
#  reissued_once_at      :datetime
#  reissued_once_by      :bigint
#  reissued_thrice_at    :datetime
#  reissued_thrise_by    :bigint
#  reissued_twice_at     :datetime
#  reissued_twice_by     :bigint
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

  aasm timestamps: true do
    state :absent, initial: true, display: "Not Checked In"
    state :checked_in, display: 'Checked In'
    state :reissued_once, display: 'Checked In (1st Reissue)'
    state :reissued_twice, display: 'Checked In (2nd Reissue)'
    state :reissued_thrice, display: 'Checked In (3rd Reissue)'
    state :last_chance, display: 'Checked In (4th Reissue)'
    state :ejected, display: 'Ejected'

    after_all_transitions :sign_status_change

    event :checkin do
      transitions from: :absent, to: :checked_in
    end

    event :uncheckin do
      transitions to: :absent
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

  def self.valid_states
    aasm.states.map(&:name)
  end

  protected

  def sign_status_change(*args)
    by = args.first[:by]
    if by.present?
      field = "#{aasm.to_state}_by".to_sym
      if has_attribute? field
        self[field] = by.id
      end
    end
  end


end
