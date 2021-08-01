# frozen_string_literal: true
require 'csv'

class AttendeeExportService
  def export
    csv = CSV.generate do |csv|
      Attendee.find_each do |a|
        next if a.printable_membership_type.nil?

        csv << [a.id, a.badge_name.first(29), a.printable_membership_type]
      end
    end

    csv
  end
end
