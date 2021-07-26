# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'registration@convergence-con.org'
  layout 'mailer'
end
