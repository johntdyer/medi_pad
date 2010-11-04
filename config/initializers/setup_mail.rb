# ActionMailer::Base.smtp_settings = {  
#   :address              => "smtp.gmail.com",  
#   :port                 => 587,  
#   :domain               => "cfgp.heroku.com",  
#   :user_name            => "cfpgone",  
#   :password             =>  'cfpgtestone@gmail.com',  
#   :authentication       => "plain",  
#   :enable_starttls_auto => true  
# }                                              


ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => '25',
  :domain => ENV['SENDGRID_DOMAIN'],
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD']
}