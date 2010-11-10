class Option < ActiveRecord::Base
  has_and_belongs_to_many :procedures

  validates_presence_of :procedure_id, :on => :create, :message => "Required"
  validates_uniqueness_of :description, :message => "Name must be unique" 
  validates_uniqueness_of :value, :message => "Name must be unique" 
  validates_presence_of :description, :on => :create, :message => "Required"  
  validates_presence_of :value, :on => :create, :message => "Required"  
end
