class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
		auth = request.env['omniauth.auth']
		@user = User.from_auth_provider(auth)
		if @user.persisted?
			sign_in_and_redirect @user, event: :authentication
		else
			session['devise.' + auth.provider] = auth
			redirect_to new_user_registration_url
		end
	end

end
