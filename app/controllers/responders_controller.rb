class RespondersController < ApplicationController
  def index
    render json: Responder.all
  end

  def create
    responder = Responder.new(responder_params(:on_duty))
    if responder.save
      render json: responder, status: :created
    else
      render json: { message: responder.errors }, status: :unprocessable_entity
    end
  end

  def show
    responder = Responder.find_by(name: params[:name])
    if responder
      render json: responder
    else
      head :not_found
    end
  end

  def update
    responder = Responder.find_by(name: params[:name])
    if responder.update(responder_params(:name, :capacity, :type))
      render json: responder
    else
      head :unprocessable_entity
    end
  end

  private

  def responder_params(*without)
    params.require(:responder).permit([:type, :name, :capacity, :on_duty] - without)
  end
end
