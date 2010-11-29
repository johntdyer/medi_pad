class Charge < ActiveRecord::Base
  has_one :procedure
  belongs_to :patient
  has_one :note

end
