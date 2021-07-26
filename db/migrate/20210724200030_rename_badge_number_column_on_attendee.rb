# frozen_string_literal: true

class RenameBadgeNumberColumnOnAttendee < ActiveRecord::Migration[6.1]
  def change
    rename_column :attendees, :badge_number, :neon_attendee_id
  end
end
