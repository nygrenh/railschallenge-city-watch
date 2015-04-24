class StatisticalEmergency
  attr_reader :emergencies

  def initialize(emergencies)
    @emergencies = emergencies
  end

  def full_responses
    [Emergency.fully_responded.count, Emergency.count]
  end
end
