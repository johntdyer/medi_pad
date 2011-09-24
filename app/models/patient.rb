class Patient < ActiveRecord::Base
  
  far_out_date=DateTime.parse('01/23/4567').to_date
  
  has_many :charges
  has_many :admissions, :dependent => :destroy
 
  after_create :create_admission

  default_scope :order=>'room DESC'
  default_value_for :patient_been_seen, false
  default_value_for :discharged, false
  
  # When we creat a patient we want to set the date to he was last added to NOW
  default_value_for :date_last_added, DateTime.now

  validates_presence_of :patient_name, :on => :create, :message => "Name can't be blank"
  validates_presence_of :facility, :on => :create, :message => "Facility can't be blank"
  validates_presence_of :fin, :on => :create, :message => "FIN number can't be blank"  
  validates_uniqueness_of :fin, :message => "Patient Exists" 
  validates_numericality_of :fin, :message => "FIN can be only numbers" 

  private

  def create_admission
     Admission.create(:patient_id=>self.id,:checkin=>Date.today)
  end

  # All Active Patients
  def self.active
      Admission.scoped(
          :conditions => ['checkout IS NULL'], 
          :include => :patient
         ).map(&:patient).uniq.sort_by { |patient_record| patient_record[:room].to_i }
  end
  

  def self.day(date)
     tomorrow=date+1.day
  #     logger.debug { "\n\t#{DateTime.parse(1294894800)}" }
  #     logger.debug { "\t#{DateTime.parse(tomorrow)}\n\n" }       
    Admission.scoped(
              :conditions => ['checkin <= ? AND checkout <= ? OR NULL', Time.at(date).to_date, Time.at(date).to_date+1.day], 
              :include => :patient ).map(&:patient).uniq.sort_by { |patient_record| patient_record[:room].to_i }  
   end
   
   
  def self.between_range(lower_date,upper_date) 
    datesArr=Array.new
      while Date.today > lower_date do
        lower_date = lower_date + 1
        datesArr<<lower_date
      end
    Admission.scoped(
                  :conditions => ['checkin IN (?)', datesArr],
                  :include => :patient
                ).map(&:patient).uniq.sort_by { |patient_record| patient_record[:room].to_i }
  end

  def self.after(lower_dateTime)
    Admission.scoped(
                  :conditions => ['checkin > ?', lower_dateTime],
                  :include => :patient
                ).map(&:patient).uniq.sort_by { |patient_record| patient_record[:room].to_i }
  end

  def self.before(upper_dateTime)
    Admission.scoped(
                  :conditions => ['checkin <= ?', upper_dateTime],
                  :include => :patient
                ).map(&:patient).uniq.sort_by { |patient_record| patient_record[:room].to_i }
  end


  def self.since(upper_dateTime=DateTime.now)
    Admission.scoped(
          :conditions => ['checkout IS NULL AND checkin <= ? ', upper_dateTime.midnight.to_date+1.day-1.second],
          :include => :patient
        ).map(&:patient).uniq.delete_if {|x| x == nil}.sort_by { |patient| patient[:room] }
  end
    
  def self.since(upper_dateTime=DateTime.now)
    Admission.scoped(
          :conditions => ['checkout IS NULL]', upper_dateTime.midnight.to_date+1.day-1.second],
          :include => :patient
        ).map(&:patient).uniq.delete_if {|x| x == nil}.sort_by { |patient| patient[:room] }
  end

 
  # Find active paties but not ones active after a certain date 
  # Example  Get all active patients but not ones before A date
  def self.active_limited(opts={}) 
      opts={ :date_ceiling=>Date.today }.merge(opts)
      Admission.scoped(:conditions => ['checkout = ? AND checkin <=?',far_out_date,current_date], :include => :patient).map(&:patient).uniq
  end
  
  #.delete_if{|patient|  patient.admissions.last.checkin>=opts[:date_ceiling] }
  
end