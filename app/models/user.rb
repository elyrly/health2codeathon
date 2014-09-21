class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

attr_accessible :email, :password, :password_confirmation

has_many :meds

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
