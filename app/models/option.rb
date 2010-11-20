class Option < ActiveRecord::Base
  belongs_to :procedures
  has_many :locations
  has_many :types
  validates_presence_of :procedure_id, :on => :create, :message => "Required"

  validates_presence_of :description, :on => :create, :message => "Required"  
  validates_presence_of :value, :on => :create, :message => "Required"  
end
