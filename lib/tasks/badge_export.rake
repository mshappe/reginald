task :badge_export => :environment do
  pp AttendeeExportService.new.export
end
