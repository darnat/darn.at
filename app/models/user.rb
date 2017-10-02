class User < ApplicationRecord

	attr_accessor :login

  has_many :auth_providers
  has_many :tutorials

	validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9 _\.]*\z/}
  validates :country_code, length: {is: 2}, format: { with: /\A[A-Z]+\z/ }, allow_nil: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:facebook]


    def self.find_first_by_auth_conditions(warden_conditions)
    	conditions = warden_conditions.dup
    	if login = conditions.delete(:login)
    		where(conditions.to_h).where("lower(email) = :value OR lower(username) = :value", value: login.downcase).first
    	else
    		where(conditions.to_h).first
    	end
    end


    ## Register or SignIn or User from a provider
    def self.from_auth_provider(auth)
      if provider = AuthProvider.where('name = :provider AND uid = :uid', {:provider => auth.provider, :uid => auth.uid}).first
        return provider.user
      end
      @user = where('email = :email', { :email => auth.info.email }).first_or_create do |user|
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.username = auth.info.name
        user.password = Devise.friendly_token[0, 20]
        user.skip_confirmation!
      end
      if @user.persisted?
        @user.auth_providers.create(:name => auth.provider, :uid => auth.uid)
      end
      @user
    end

end
