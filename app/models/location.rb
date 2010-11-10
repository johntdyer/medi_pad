class Location < ActiveRecord::Base
  belongs_to :charge
  validates_presence_of :procedure_id, :on => :create, :message => "procedure id required"
  
end
