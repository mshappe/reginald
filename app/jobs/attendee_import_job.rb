class AttendeeImportJob < ApplicationJob
  queue_as :default

  def perform(file, user)
    AttendeeImportService.new.import(file)
    AttendeeImportMailer.success(file, user).deliver_later
  rescue StandardError => e
    AttendeeImportMailer.failure(file, user, e).deliver_later
  end
end
