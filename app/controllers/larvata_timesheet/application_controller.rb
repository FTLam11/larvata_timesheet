module LarvataTimesheet
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: { message: exception.message }, status: 401
    end
  end
end
