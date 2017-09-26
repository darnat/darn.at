class User < ApplicationRecord

	attr_accessor :login

	validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9 _\.]*\z/}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


    def self.find_first_by_auth_conditions(warden_conditions)
    	conditions = warden_conditions.dup
    	if login = conditions.delete(:login)
    		where(conditions.to_h).where("lower(email) = :value OR lower(:username) = :value", value: login.downcase).first
    	else
    		where(conditions.to_h).first
    	end
    end

end
