class ResponderCapacity
  include ActiveModel::Serialization
  attr_accessor :fire, :police, :medical

  def initialize
    @fire = statistics_for(Responder.fire)
    @police = statistics_for(Responder.police)
    @medical = statistics_for(Responder.medical)
  end

  private

  def statistics_for(scope)
    [
      scope.sum(:capacity),
      scope.available.sum(:capacity),
      scope.on_duty.sum(:capacity),
      scope.ready.sum(:capacity)
    ]
  end
end
