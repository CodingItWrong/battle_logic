module BattleLogic
  class Character
    attr_reader :max_health, :current_health

    def initialize(opts = {})
      @current_health = @max_health = opts.fetch(:max_health, 1)
    end

    def alive?
      current_health > 0
    end

    def dead?
      !alive?
    end

    def receive_damage!
      @current_health -= 1 if current_health > 0
    end

    def attack(defender)
      defender.receive_damage!
    end
  end
end
