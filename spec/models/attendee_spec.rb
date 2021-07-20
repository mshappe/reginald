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
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
