class Doctor < ActiveRecord::Base
	belongs_to :charge
	belongs_to :patient
end
