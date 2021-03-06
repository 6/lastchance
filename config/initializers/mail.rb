ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => ENV['GMAIL_SMTP_USER'],
  :password             => ENV['GMAIL_SMTP_PASS'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

#ActionMailer::Base.default_url_options[:host] = "localhost:5000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
