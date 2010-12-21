class Patient < ActiveRecord::Base  
 
  default_value_for :patient_been_seen, false
  default_value_for :discharged, false
  
  # When we creat a patient we want to set the date to he was last added to NOW
  default_value_for :date_last_added, DateTime.now


   
  validates_presence_of :patient_name, :on => :create, :message => "Name can't be blank"
  validates_presence_of :facility, :on => :create, :message => "Facility can't be blank"
  validates_presence_of :fin, :on => :create, :message => "FIN number can't be blank"  
  validates_uniqueness_of :fin, :message => "Patient Exists" 
  validates_numericality_of :fin, :message => "FIN can be only numbers" 
	has_many :charges


end
