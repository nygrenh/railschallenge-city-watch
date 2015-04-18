class ResponderCapacity
  attr_accessor :fire, :police, :medical

  def initialize
    p Responder.all.pluck(:capacity, :on_duty)
    @fire = Responder.available.where(type: 'Fire').pluck(:capacity)
    @police = Responder.available.where(type: 'Police').pluck(:capacity)
    @medical = Responder.available.where(type: 'Medical').pluck(:capacity)
  end
end
