ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "myrailz.com",  
    :user_name => " cfpg.pad",
    :authentication       => "plain",
    :password  => "cfpgtestone",
    :enable_starttls_auto => true
  }

# ActionMailer::Base.smtp_settings = {  
#   :address              => "smtp.gmail.com",  
#   :port                 => 587,  
#   :domain               => "myrailz.com",  
#   :user_name            => "cfpgtestone",  
#   :password             =>  'cfpgtestone@gmail.com',  
#   :authentication       => "plain",  
#   :enable_starttls_auto => true  
# }                                              
# 

