# frozen_string_literal: true

class AddStateTimestampsToAttendee < ActiveRecord::Migration[6.1]
  def change
    add_column :attendees, :checked_in_at, :datetime
    add_column :attendees, :checked_in_by, :bigint
    add_column :attendees, :reissued_once_at, :datetime
    add_column :attendees, :reissued_once_by, :bigint
    add_column :attendees, :reissued_twice_at, :datetime
    add_column :attendees, :reissued_twice_by, :bigint
    add_column :attendees, :reissued_thrice_at, :datetime
    add_column :attendees, :reissued_thrise_by, :bigint
    add_column :attendees, :last_chance_at, :datetime
    add_column :attendees, :last_chance_by, :bigint
    add_column :attendees, :ejected_at, :datetime
    add_column :attendees, :ejected_by, :bigint
  end
end
