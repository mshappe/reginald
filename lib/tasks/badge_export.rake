task :badge_export => :environment do
  puts AttendeeExportService.new.export
end
