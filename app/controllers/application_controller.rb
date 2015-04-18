class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # Tell the user if we have unpermitted parameters
  rescue_from(ActionController::UnpermittedParameters) do |exception|
    render json: { message: exception.to_s }, status:  :unprocessable_entity
  end

  def extra_attributes
    @extra_attributes ||= []
  end

  def allow_attributes!(*attributes)
    @extra_attributes = extra_attributes + attributes
  end

  def allowed_attributes
    common_allowed_attributes + extra_attributes
  end

  # Override this method to define common attributes
  def common_allowed_attributes
    []
  end
end
