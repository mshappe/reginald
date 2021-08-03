# frozen_string_literal: true

namespace :export do
  task badges: :environment do
    puts AttendeeExportService.new.export
  end

  task art_show: :environment do
    puts AttendeeExportService.new.export :art_show
  end
end
