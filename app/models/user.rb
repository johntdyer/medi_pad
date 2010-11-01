class User < ActiveRecord::Base

  default_value_for :favorites, "--- []\\n\\n"
  default_value_for :validated, false
  default_value_for :is_admin, false
  belongs_to :charge
  belongs_to :patient

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable,:lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :favorites, :last_name, :validated, :first_name, :password, :password_confirmation, :remember_me
end
