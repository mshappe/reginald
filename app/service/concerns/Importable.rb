module Importable
include ActiveSupport::Concern

  COLUMNS = {
    'Event Registration ID' => :transaction_id,
    'Registration Date/Time' => :registered_at,
    'Event Name' => :event_name,
    'Event ID' => :event_id,
    'Attendee Account ID' => :neon_attendee_id,
    'Address Line 1' => :address1,
    'Address Line 2' => :address2,
    'City' => :city,
    'State/Province' => :state,
    'Zip' => :zip,
    'Country' => :country,
    'Attendee Email' => :email,
    'Attendee Full Name (F)' => :legal_name,
    'Preferred First Name (C)' => :preferred_first_name,
    'Preferred Last Name (C)' => :preferred_last_name,
    'Event Ticket Name' => :membership_type,
    'Phone 1' => :phone_number,
    'Phone 1 Area Code' => :area_code,
    'Registrant Account ID' => :registrant_id,
    'Registrant Full Name (F)' => :registrant_legal_name,
    'Badge Name (C)' => :badge_name,
    'Guest Of Badge (C)' => :guest_badge,
    'Operations Hold - Do Not Release (C)' => nil,
    'In Case Of Emergency (Name and Phone) (C)' => :emergency_contact,
    'Membership: Badge Name (C)' => :badge_name,
    'Membership: Personal Email Address (C)' => :email,
    'Business: Email Address (C)' => nil,
    'Business Contact: First Name (C)' => nil,
    'Business Contact: Last Name (C)' => nil,
    'Business Name (C)' => nil,
    'Membership: First Name (C)' => nil,
    'Membership: Last Name (C)' => nil,
    'Dealer Table Notes (C)' => nil
  }
end
