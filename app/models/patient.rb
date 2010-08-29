class Patient < ActiveRecord::Base
  validates_presence_of :patient_name, :on => :create, :message => "Name can't be blank"
  validates_presence_of :facility, :on => :create, :message => "Facility can't be blank"
  validates_uniqueness_of :fin, :message => "Patient Exists"
	has_many :charges
end
