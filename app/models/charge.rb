class Charge < ActiveRecord::Base
	has_one :procedure
	belongs_to :patients
end
