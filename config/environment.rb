# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Fasonla::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default :content_type => "text/html"
# 
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :domain => "hungdung.com.vn",
  :user_name => 'anhtu',
  :password => 'anhtu2008',
  :authentication => 'plain',
}