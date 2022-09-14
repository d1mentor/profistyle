class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        stored_location_for(resource) ||
          if resource.is_a?(User)
            "/admin_panel/home"
          else
            super
          end
      end

      def after_sign_out_path_for(resource)
        stored_location_for(resource) ||
          if resource.is_a?(User)
            "/?lang=ru"
          else
            "/?lang=ru"
          end
      end
      
protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to "/admin_panel/login"
    end
  end
end
