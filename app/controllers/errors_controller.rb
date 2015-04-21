class ErrorsController < ApplicationController
  def error_404
    render json: { message: 'page not found' }, status: :not_found
  end
end
