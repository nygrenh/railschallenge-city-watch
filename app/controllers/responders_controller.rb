class RespondersController < ApplicationController
  def create
    responder = Responder.new(responder_params)
    if responder.save
      render json: responder, status: :created
    else
      render json: { message: responder.errors }, status: :unprocessable_entity
    end
  end

  private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
