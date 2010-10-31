class User < ActiveRecord::Base

  default_value_for :favorites, "--- []\\n\\n"

  belongs_to :charge
  belongs_to :patient

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :favorites, :last_name, :first_name, :password, :password_confirmation, :remember_me
end
