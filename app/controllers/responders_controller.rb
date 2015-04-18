class RespondersController < ApplicationController

  def create
    responder = Responder.new(responder_params)
    if responder.save
      render json: responder, status: :created
    else
      render json: { message: responder.errors }, status: :unprocessable_entity
    end
  end

  def update
    responder = Responder.find_by(name: params[:name])
    responder.update(responder_params)
  end

  private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
