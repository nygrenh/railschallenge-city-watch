class RespondersController < ApplicationController
  def index
    if params[:show] == 'capacity'
      render json: ResponderCapacity.new
    else
      render json: Responder.all
    end
  end

  def create
    responder = Responder.new(create_params)
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
      error_404
    end
  end

  def update
    responder = Responder.find_by(name: params[:name])
    if responder.update(update_params)
      render json: responder
    else
      render json: responder.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:responder).permit(:on_duty)
  end

  def create_params
    params.require(:responder).permit(:name, :capacity, :type)
  end
end
