class ResponderDispatcher
  RESPONDER_TYPES = [Responder.fire, Responder.police, Responder.medical]

  def initialize(emergency)
    @emergency = emergency
  end

  def dispatch
    full_response = true
    RESPONDER_TYPES.each do |responder|
      result = Dispatcher.new(responder, @emergency).dispatch
      full_response = false unless result
    end
    full_response
  end

  class Dispatcher
    def initialize(responders, emergency)
      @responders = responders
      @emergency = emergency
    end

    def dispatch
      return false if @responders.empty?
      need = emergency_severity
      while need > 0
        best = best_candidate(need)
        return false unless best
        assign(best)
        need -= best.capacity
      end
      true
    end

    def emergency_severity
      type = @responders.first.type
      @emergency.send("#{type}_severity")
    end

    def assign(responder)
      return unless responder
      responder.emergency_code = @emergency.code
      responder.save
      remove_from_list(responder)
    end

    def remove_from_list(responder)
      grouped_emergency[responder.capacity].delete(responder)
      grouped_emergency.delete(responder.capacity) if grouped_emergency[responder.capacity].empty?
    end

    def best_candidate(need)
      return emergency_candidate(need) if grouped_emergency[need]
      need = next_smaller_capacity(need) || next_bigger_capacity(need)
      emergency_candidate(need)
    end

    def next_smaller_capacity(need)
      grouped_emergency.keys.find_all { |c| c < need }.max
    end

    def next_bigger_capacity(need)
      grouped_emergency.keys.find_all { |c| c > need }.min
    end

    def emergency_candidate(need)
      grouped_emergency[need].first if grouped_emergency[need]
    end

    def grouped_emergency
      @grouped_emergency ||= @responders.ready.group_by(&:capacity)
    end
  end
end
