class ApplicationController < ActionController::Base
  before_action :redirect_from_www_to_non_www_host

  def redirect_from_www_to_non_www_host
    domain_parts = request.host.split('.')
    if domain_parts.first == 'www'
      redirect_to(request.original_url.gsub('www.', ''), status: 301, allow_other_host: true) and return  
    end
  end  
  
  def after_sign_in_path_for(resource)
        stored_location_for(resource) ||
          if resource.is_a?(User)
            "/admin_panel/"
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
