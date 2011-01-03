class Charge < ActiveRecord::Base
  has_one :procedure
  belongs_to :patient #,:touch => :updated_at
  has_one :note

end
