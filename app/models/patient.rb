class Patient < ActiveRecord::Base
#  before_create :admit_status
  
  has_many :charges
  has_many :admissions  

  default_value_for :patient_been_seen, false
  default_value_for :discharged, false
  
  # When we creat a patient we want to set the date to he was last added to NOW
  default_value_for :date_last_added, DateTime.now

  validates_presence_of :patient_name, :on => :create, :message => "Name can't be blank"
  validates_presence_of :facility, :on => :create, :message => "Facility can't be blank"
  validates_presence_of :fin, :on => :create, :message => "FIN number can't be blank"  
  validates_uniqueness_of :fin, :message => "Patient Exists" 
  validates_numericality_of :fin, :message => "FIN can be only numbers" 
	
	 scope :today, lambda { |day| days_patients(day) }
  
  
  private
  
  def self.days_patients(day)
      Admission.where(
         :conditions => ['checkin >= ? AND checkin < ?',  session[:selected_time].to_date,  session[:selected_time].to_date+1.day], 
         :include => :patient).map(&:patient).uniq
    end

  
  # private
  #   
  #   def admit_status
  #     
  #     admit_status = Admission.find_last_by_patient_id(self.id)
  #   
  #     unless admit_status
  #       #Patient has never been admitted, create an admission record
  #       Admission.create(:patient_id=>self.id,:checkin=>Date.today)
  #       logger.debug "\n\n\t===>Create an admit record for new patient ID: #{self.id}\n"
  #     else
  #       if admit_status.checkout
  #         #Patient admitted, but not checked out 
  #         logger.debug { "\n\n\tPatient still admitted\n" }
  #       else
  #         #Past patient, but we need a new admit record for this visit
  #         Admission.create(:patient_id=>self.id,:checkin=>Date.today)
  #         logger.debug "\n\n\tCreate an new admit record previous patient ID: #{self.id}\n"
  #       end 
  #     end                      
  # end

end
