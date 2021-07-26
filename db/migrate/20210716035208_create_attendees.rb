# frozen_string_literal: true

class CreateAttendees < ActiveRecord::Migration[6.1]
  def change
    create_table :attendees do |t|
      t.integer :event_id, index: true
      t.string :event_name
      t.integer :badge_number, index: true
      t.boolean :guest_badge
      t.string :badge_name, index: true
      t.string :emergency_contact
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :email
      t.string :legal_name
      t.string :preferred_first_name
      t.string :preferred_last_name
      t.string :membership_type
      t.string :area_code
      t.string :phone_number
      t.integer :registrant_id
      t.string :registrant_legal_name

      t.timestamps null: false
    end
  end
end
