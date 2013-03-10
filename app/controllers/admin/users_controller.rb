class Admin::UsersController < Admin::ResourcesController
  def send_emails
    students = User.where(:email_sent => true, :match_email_sent => false)
    with_matches = []
    without_matches = []
    students.each{|s|
      matches = []
      (s.choices).each{|choice|
        begin
          s2 = User.find(choice)
          next if s2.id == s.id # people trying to choose themselves
          matches << s2 if s2.choices.include?(s.id)
        rescue
        end
      } 
      if matches.length > 0
        #UserMailer.match_email(s, matches).deliver
        #s.update_attributes(:match_email_sent => true)
        with_matches << s
      else
        #s.update_attributes(:match_email_sent => true)
        without_matches << s
      end
    }
    if students.length > 0
      text = "Match emails are being sent now to:<br>#{with_matches.to_sentence}<br><br>The following students listed some people but did not have any matches (and won't be sent an email):<br>#{without_matches.to_sentence}"
    else
      text = "It seems like all match emails were already sent."
    end
    render :text => text
  end
  
  def stats
    students = User.where(:email_sent => true).order("name ASC")
    @students_with_choices = students.reject{|s| s.choices.length == 0}
    @students_without_choices = students.reject{|s| s.choices.length > 0}
  end

  def toggle_polling
    Setting.polls_closed = !Setting.polls_closed
    render :text => "Polling #{Setting.polls_closed ? 'closed' : 'opened'}. <a href='/admin'>Back to admin panel</a>"
  end
end
