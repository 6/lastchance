class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = ENV['GMAIL_SMTP_USER']
  end
end
