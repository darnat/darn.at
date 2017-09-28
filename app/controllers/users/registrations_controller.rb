class Users::RegistrationsController < Devise::RegistrationsController

	protected

	def update_resource(resource, params)
        if params[:password].blank?
          params.delete(:password)
          params.delete(:password_confirmation) if params[:password_confirmation].blank?
        end
        resource.update_attributes(params)
        resource.clean_up_passwords
        true
	end

	def after_update_path_for(resource)
		edit_user_registration_path
	end

end