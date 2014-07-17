class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 	protected
	def configure_permitted_parameters
					devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
	end

	def login_required
		if current_user.blank?
			respond_to do |format|
			format.html {
				authenticate_user!
			}
			format.js{
				render :partial => "common/not_logined"
			}
			format.all {
				head(:unauthorized)
			}
			end
		end
	end

  protect_from_forgery with: :exception
end
