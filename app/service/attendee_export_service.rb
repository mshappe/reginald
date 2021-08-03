# frozen_string_literal: true

require 'csv'

class AttendeeExportService
  def export(type = :default)
    CSV.generate do |csv|
      csv << ['Badge #', 'Badge Name', 'Legal Name', 'Preferred Name', 'Email'] if type == :art_show
      Attendee.find_each do |a|
        next if a.printable_membership_type.nil?

        case type
        when :default
          dealer = ''
          dealer = 'DEALER' if a.dealer?
          csv << [a.id, a.badge_name&.first(29), a.printable_membership_type]
        when :art_show
          csv << [a.id, a.badge_name&.first(29), a.legal_name, a.preferred_name, a.email]
        end
      end
    end
  end
end
