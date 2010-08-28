class Import < ActiveRecord::Base
	belongs_to :patient

  has_attached_file :patient_data
  
end
