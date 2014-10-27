class Emailer < ActionMailer::Base
  def createmail(user, status, exception, url, sent_at = Time.now)
    @user = user
    @status = status
    @exception = exception
    @url = url
    @sent_on = sent_at
    mail(:to => "anhtu.nkh@gmail.com",
         :from => "anhtu.nkh@gmail.com",
         :subject => t('emailer_error.subject') + " [ status: #{status} ] ",
         :content_type => "text/html") do |format|
      format.html { render 'errors/mail_error_view' }
    end
  end
end
