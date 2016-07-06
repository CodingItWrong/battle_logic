module BattleLogic
  class Character
    attr_reader :max_health, :current_health, :attack_rating

    def initialize(opts = {})
      @current_health = @max_health = opts.fetch(:max_health, 1)
      @attack_rating = opts.fetch(:attack_rating, 1)
    end

    def alive?
      current_health > 0
    end

    def dead?
      !alive?
    end

    def receive_damage!(damage = 1)
      @current_health -= damage
      @current_health = 0 if current_health < 0
    end

    def attack(defender)
      defender.receive_damage!(attack_rating)
    end
  end
end
