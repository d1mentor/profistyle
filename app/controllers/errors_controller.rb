
class ErrorsController < ApplicationController
  def not_found
    #render status: 404
    redirect_to "/"
  end

  def internal_server_error
    #render status: 500
    redirect_to "/"
  end
end
