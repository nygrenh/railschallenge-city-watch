class ErrorsController < ApplicationController
  def error_404
    render json: { hello: 'world' }
  end
end
