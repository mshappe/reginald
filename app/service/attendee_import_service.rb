require 'csv'

class AttendeeImportService
  include Importable

  def import(file)
    data = []

    csv = CSV.read(file, headers: true)
    csv.by_row!
    csv.each do |r|
      datum = {}
      COLUMNS.keys.each do |c|
        attr = COLUMNS[c]
        next if attr.nil?

        # We have some fields that map to the same attrs
        next if datum[attr].present?

        if Attendee.has_attribute? attr
          datum[attr] = r[c]
        end
      end
      datum[:created_at] = Time.zone.now
      datum[:updated_at] = datum[:created_at]

      # Guest badge is a boolean for us
      datum[:guest_badge] = datum[:guest_badge].present?
      data << datum
    end

    Attendee.upsert_all(data)
    Rails.logger.info "DONE WITH ENGINES"
  end


end