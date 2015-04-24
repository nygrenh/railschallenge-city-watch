class EmergenciesController < ApplicationController
  before_action :set_emergency, only: [:show, :update]

  def index
    render json: StatisticalEmergency.new(Emergency.all)
  end

  def show
    if @emergency
      render json: @emergency
    else
      head :not_found
    end
  end

  def create
    emergency = Emergency.new(create_params)
    if emergency.save
      render json: emergency, status: :created
    else
      render json: emergency.errors, status: :unprocessable_entity
    end
  end

  def update
    if @emergency.update(update_params)
      render json: @emergency
    else
      render json: responder.errors, status: :unprocessable_entity
    end
  end

  private

  def set_emergency
    @emergency = Emergency.find_by(code: params[:code])
  end

  def update_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end

  def create_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :code)
  end
end
