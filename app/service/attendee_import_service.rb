# frozen_string_literal: true

require 'csv'

class AttendeeImportService
  include Importable

  def import(file)
    csv = CSV.read(file, headers: true)
    csv.by_row!
    csv.each do |r|
      datum = {}
      COLUMNS.each_key do |c|
        attr = COLUMNS[c]
        next if attr.nil?

        # We have some fields that map to the same attrs
        next if datum[attr].present?

        datum[attr] = r[c] if Attendee.has_attribute? attr
      end
      #datum[:created_at] = Time.zone.now
      #datum[:updated_at] = datum[:created_at]

      # Guest badge is a boolean for us
      datum[:guest_badge] = datum[:guest_badge].present?
      Attendee.create! datum
    end

    Rails.logger.info 'DONE WITH ENGINES'
  end
end
