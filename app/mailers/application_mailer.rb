# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'doboszmichal33@gmail.com'
  layout 'mailer'
end
