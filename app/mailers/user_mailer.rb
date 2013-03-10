class UserMailer < ActionMailer::Base
  default from: "Last Chance Dance <#{ENV['GMAIL_SMTP_USER']}>"
  
  def confirm_email(user)
    @user = user
    @url  = "#{ENV['BASE_URL']}/confirm/#{@user.salt}"
    mail(:to => "#{user.email}@colby.edu", :subject => "Last Chance Dance")
  end
  
  def match_email(user, matches)
    @user = user
    @matches = matches
    mail(:to => "#{user.email}@colby.edu", :subject => "Last Chance Dance Matches")
  end
end
