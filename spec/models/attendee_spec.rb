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
require 'rails_helper'

RSpec.describe Attendee, type: :model do
end
