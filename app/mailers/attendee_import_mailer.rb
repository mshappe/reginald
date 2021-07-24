class AttendeeImportMailer < ApplicationMailer
  def success(file, user)
    @file = file
    @total = Attendee.count
    mail(to: user.email, subject: 'Import successful')
  end

  def failure(file, user, e)
    @file = file
    @e = e
    mail(to: user.email, subject: 'Import failed badly')
  end

end
