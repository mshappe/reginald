# frozen_string_literal: true

require 'csv'

class AttendeeImportService
  include Importable

  def import(file)
    csv = CSV.read(file, headers: true)
    csv.by_row!
    csv.each do |r|
      datum = {}

      # Skip blanks
      next if r['Event Ticket Name'].blank?

      COLUMNS.each_key do |c|
        attr = COLUMNS[c]
        next if attr.nil?

        # We have some fields that map to the same attrs
        next if datum[attr].present?

        datum[attr] = r[c] if Attendee.has_attribute? attr
      end

      # Guest badge is a boolean for us
      datum[:guest_badge] = datum[:guest_badge].present?
      datum[:registered_at] = Time.zone.strptime datum[:registered_at], '%m/%d/%Y %H:%M' unless datum[:registered_at].blank?

      # Dealers attendee names are different
      if r['Event Ticket Name'] == 'Dealer'
        full_name = "#{r['Membership: First Name (C)']} #{r['Membership: Last Name (C)']}"
        email = (r['Business: Email Address (C)']).to_s
        badge_name = (r['Membership: Badge Name (C)']).to_s
        datum[:legal_name] = full_name
        datum[:email] = email
        datum[:badge_name] = badge_name
      end

      Attendee.create! datum
    end

    Rails.logger.info 'DONE WITH ENGINES'
  end
end
