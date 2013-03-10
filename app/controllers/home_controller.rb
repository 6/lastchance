class HomeController < ApplicationController
  before_filter :deny_if_closed
  before_filter :login_required, :only => [:choose, :process_choices]

  def confirm_email
    if params[:email].present?
      @user = User.find_by_email(params[:email].downcase.split("@")[0])
      if @user.present?
        # send max 1 email per day
        @user.update_attributes(:email_sent => false) if @user.updated_at < 1.day.ago
        if @user.email_sent
          text = "It looks like we've already sent an email to #{@user.email}@colby.edu. Check your Spam folder if you don't see it in your inbox"
        else
          text = "Success"
          UserMailer.confirm_email(@user).deliver
          @user.update_attributes(:email_sent => true)
        end
        return render :text => "#{text}. Go check your email: <a href='http://email.colby.edu'>http://email.colby.edu</a>"
      end
    end
    redirect_to root_url, :notice => "Sorry, to participate you must be a senior and use your @colby.edu email address."
  end

  def validate_email
    @user = User.find_by_salt(params[:salt])
    if @user.present?
      cookies[:salt] = @user.salt
      return redirect_to choose_path
    end
    render :text => "Something went wrong..."
  end

  def choose
    @user = User.find_by_salt(cookies[:salt])
    @options = User.where("id != ?", @user.id).order('name ASC')
  end

  def process_choices
    @user = User.find_by_salt(cookies[:salt])
    @user.update_attributes(
      :choice_1 => params[:choice_0],
      :choice_2 => params[:choice_1],
      :choice_3 => params[:choice_2],
      :choice_4 => params[:choice_3],
      :choice_5 => params[:choice_4],
      :choice_6 => params[:choice_5],
      :choice_7 => params[:choice_6],
      :choice_8 => params[:choice_7],
      :choice_9 => params[:choice_8],
      :choice_10 => params[:choice_9]
    )
    cookies[:salt] = nil
    render :text => "Thanks! Have fun, Be safe!"
  end

  private

  def deny_if_closed
    render :text => "<!DOCTYPE html><meta charset='utf-8'>Polling is closed, and all emails have been sent. If you don't see the email in your inbox, check your spam folder. If you have any problems, contact #{ENV['GMAIL_SMTP_USER']}.<br><br>If you didn't get an email, that means that you did not have any mutual matches.</ul>" if Setting.polls_closed
  end

  def login_required
    unless cookies[:salt].present?
      redirect_to root_url, :alert => "Please reauthenticate by clicking on the link in your confirmation email."
    end
  end
end
