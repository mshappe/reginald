# frozen_string_literal: true

class AttendeeImportJob < ApplicationJob
  queue_as :default

  def perform(file, user)
    AttendeeImportService.new.import(file)
    AttendeeImportMailer.success(file, user).deliver_now
  rescue StandardError => e
    AttendeeImportMailer.failure(file, user, e).deliver_now
  end
end
