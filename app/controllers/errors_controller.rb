
class ErrorsController < ApplicationController
  def not_found
    redirect_to "/404"
  end

  def not_found_page
    render "errors/404"
  end  

  def internal_server_error
    render status: 500
  end
end
