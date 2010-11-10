class Procedure < ActiveRecord::Base   
  validates_uniqueness_of :procedure_code, :message => "Procedure Code Must be unique" 
	belongs_to :charge
	has_many :options
end
