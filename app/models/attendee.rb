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
class Attendee < ApplicationRecord
  include AASM

  has_paper_trail

  aasm timestamps: true do
    state :absent, initial: true, display: 'Not Checked In'
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

  has_many :attendee_notes, dependent: :destroy

  scope :all_check_ins, -> { where aasm_state: Attendee.checked_in_states }
  scope :reissues, -> { where aasm_state: Attendee.reissued_states }
  scope :ejected, -> { where aasm_state: Attendee::STATE_EJECTED }

  # Membership types are a bit of a hack. Also, for 2021, we only care about Adult and Teen
  scope :adults, -> { where membership_type: 'Adult (Age 18+)' }
  scope :non_adults, -> { where membership_type: ['Teen (Ages 13 to 17)', 'Child (Ages 6 to 12)'] }

  attr_accessor :pay_type, :dummy

  def self.valid_states
    aasm.states.map(&:name)
  end

  def self.pay_states
    [Attendee::STATE_REISSUED_ONCE, Attendee::STATE_REISSUED_TWICE, Attendee::STATE_REISSUED_THRICE]
  end

  def self.reissued_states
    Attendee.pay_states + [Attendee::STATE_LAST_CHANCE]
  end

  def self.checked_in_states
    [Attendee::STATE_CHECKED_IN] + Attendee.reissued_states
  end

  def self.membership_types
    MEMBERSHIP_TYPES
  end

  def printable_membership_type
    case membership_type
    when /^Adult/
      'ADULT'
    when /^Teen/, /^Child/
      'UNDER-18'
    when /^Dealer/
      'ADULT (DEALER)'
    end
  end

  def preferred_name
    "#{preferred_first_name} #{preferred_last_name}".strip
  end

  def dealer?
    membership_type == 'Dealer'
  end

  protected

  def sign_status_change(*args)
    by = args.first[:by]
    by_field = "#{aasm.to_state}_by".to_sym
    pay = args.first[:pay_type]
    pay_field = "#{aasm.to_state}_pay_type".to_sym
    self[by_field] = by.id if by.present? && (has_attribute? by_field)

    self[pay_field] = pay if pay.present? && (has_attribute? pay_field)
  end
end
