class EmergenciesController < ApplicationController

  def index
    render json: Emergency.all
  end

  def show
    emergency = Emergency.find_by(code: params[:code])
    if emergency
      render json: emergency
    else
      head :not_found
    end
  end

  def create
    emergency = Emergency.new(emergency_params)
    if emergency.save
      render json: emergency, status: :created
    else
      render json: { message: emergency.errors }, status: :unprocessable_entity
    end
  end

  private

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
