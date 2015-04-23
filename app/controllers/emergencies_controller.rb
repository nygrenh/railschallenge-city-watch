class EmergenciesController < ApplicationController
  before_action :set_emergency, only: [:show, :update]

  def index
    fully_responded = Emergency.fully_responded.count
    emergency_count = Emergency.count
    render json: Emergency.all, meta: [fully_responded, emergency_count], meta_key: 'full_responses'
  end

  def show
    if @emergency
      render json: @emergency
    else
      head :not_found
    end
  end

  def create
    allow_attributes! :code
    emergency = Emergency.new(emergency_params)
    if emergency.save
      render json: emergency, status: :created
    else
      render json: emergency.errors, status: :unprocessable_entity
    end
  end

  def update
    allow_attributes! :resolved_at
    if @emergency.update(emergency_params)
      render json: @emergency
    else
      render json: responder.errors, status: :unprocessable_entity
    end
  end

  private

  def set_emergency
    @emergency = Emergency.find_by(code: params[:code])
  end

  def emergency_params
    params.require(:emergency).permit(allowed_attributes)
  end

  def common_allowed_attributes
    [:fire_severity, :police_severity, :medical_severity]
  end
end
