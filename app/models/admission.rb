class Admission < ActiveRecord::Base
  
  validates_presence_of :patient_id
  belongs_to :patient
  
    scope :today, lambda {
      where(['checkin= ?', DateTime.today])
    }

    scope :yesterday, lambda {
      where(['checkin= ?', DateTime.today-1.day])
    }

    scope :since, lambda{|date|
      where(['checkin >= ?', date])
    }

  def self.checked_in 
    Admission.scoped(
                  :conditions=>['checkin= ?', Date.today],
                  :include=>:patient
                ).map(&:patient).uniq
  end
end
