class RespondersController < ApplicationController
  def index
    if params[:show] == 'capacity'
      render json: ResponderCapacity.new
    else
      render json: Responder.all
    end
  end

  def create
    allow_attributes! :name, :capacity, :type
    responder = Responder.new(responder_params)
    if responder.save
      render json: responder, status: :created
    else
      render json: responder.errors, status: :unprocessable_entity
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
    allow_attributes! :on_duty
    responder = Responder.find_by(name: params[:name])
    if responder.update(responder_params)
      render json: responder
    else
      render json: responder.errors, status: :unprocessable_entity
    end
  end

  private

  def responder_params
    params.require(:responder).permit(allowed_attributes)
  end
end
