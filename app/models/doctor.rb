class Doctor < ActiveRecord::Base
#  acts_as_authentic
	belongs_to :charge
	belongs_to :patient
	
	def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end
  
  
end
