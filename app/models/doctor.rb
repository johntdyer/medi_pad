class Doctor < ActiveRecord::Base
  acts_as_authentic
	belongs_to :charge
	belongs_to :patient
end
