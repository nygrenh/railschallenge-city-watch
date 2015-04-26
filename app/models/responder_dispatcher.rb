class ResponderDispatcher
  RESPONDER_TYPES = [:fire, :police, :medical]

  def initialize(emergency)
    @emergency = emergency
  end

  def dispatch
    @emergency.full_response = true
    RESPONDER_TYPES.map do |responder|
      skip, success = Dispatcher.new(responder, @emergency).dispatch
      @emergency.full_response = false if !skip && !success
    end
  end

  class Dispatcher
    def initialize(responder_type, emergency)
      @type = responder_type
      @responders = Responder.send(responder_type).ready
      @emergency = emergency
    end

    def dispatch
      return false, severity.zero? if responders.empty?
      return true, true if severity.zero?

      responders.each do |responder|
        assign(responder)
      end
      [false, full_response?(responders)]
    end

    private

    def responders
      @selected_responders ||= begin
        best_team = @responders
        (1..@responders.length).each do |n|
          @responders.combination(n) do |responders|
            team_capacity = total_capacity(responders)
            best_team = responders if severity < team_capacity && team_capacity < total_capacity(best_team)
            return responders if team_capacity == severity
          end
        end
        best_team
      end
    end

    def full_response?(responders)
      severity <= total_capacity(responders)
    end

    def severity
      @emergency.send("#{@type}_severity")
    end

    def assign(responder)
      responder.emergency_code = @emergency.code
      responder.save!
    end

    # We have to do this here instead of of the model because
    # ActiveRecord::Relation#combination yields arrays to the
    # block
    def total_capacity(responders)
      responders.inject(0) { |a, e| a + e.capacity }
    end
  end
end
