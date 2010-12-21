class User < ActiveRecord::Base


  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["username = :value OR email = :value", { :value => value }]).first
  end
  
  
  default_value_for :favorites, "--- []\\n\\n"
  default_value_for :validated, false
  default_value_for :is_admin, false
  default_value_for :is_billing, false
  default_value_for :is_doctor, false

  validates_uniqueness_of :email, :message => "Email in use"

  belongs_to :charge
  belongs_to :patient

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable,:lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :favorites, :last_name, :first_name, :validated, :password, :password_confirmation,:is_doctor,:is_billing,:is_admin,:remember_me
end
