class Admission < ActiveRecord::Base
  
  
  validates_presence_of :patient_id
  belongs_to :patient 
	
	

  
end
