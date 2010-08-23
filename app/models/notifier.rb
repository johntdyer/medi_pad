# app/models/notifier.rb  
class Notifier < ActionMailer::Base  

  default_url_options[:host] = "localhost:3000"  
  
  def password_reset_instructions(doctor)
    subject      "Password Reset Instructions"
    from         "medi_pad@cfpulmonary.com"
    recipients   doctor.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(doctor.perishable_token)
  end
  
end
