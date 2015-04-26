class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # Tell the user if we have unpermitted parameters
  rescue_from(ActionController::UnpermittedParameters) do |exception|
    render json: { message: exception.to_s }, status:  :unprocessable_entity
  end

  def error_404
    render json: { message: 'page not found' }, status: :not_found
  end
end
