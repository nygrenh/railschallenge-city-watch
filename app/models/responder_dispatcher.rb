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
      @responders = responders.ready
      @emergency = emergency
    end

    def dispatch
      responders.each do |responder|
        assign(responder)
      end
      full_response? responders
    end

    def responders
      @selected_responders ||= begin
        need = emergency_severity
        return [] if need.zero?
        best_team = @responders
        (1..@responders.length).each do |n|
          @responders.combination(n) do |responders|
            team_capacity = total_capacity(responders)
            best_team = responders if need < team_capacity && team_capacity < total_capacity(best_team)
            return responders if team_capacity == need
          end
        end
        best_team
      end
    end

    def full_response?(responders)
      emergency_severity <= total_capacity(responders)
    end

    def emergency_severity
      return 0 if @responders.empty?
      type = @responders.first.type
      @emergency.send("#{type}_severity")
    end

    def assign(responder)
      responder.emergency_code = @emergency.code
      responder.save
    end

    # We have to do this here instead of of the model because
    # ActiveRecord::Relation#combination yields arrays to the
    # block
    def total_capacity(responders)
      responders.inject(0) { |a, e| a + e.capacity }
    end
  end
end
