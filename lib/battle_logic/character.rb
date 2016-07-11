module BattleLogic
  class Character
    attr_reader :max_health, :current_health, :attack_rating, :defense_rating

    def initialize(opts = {})
      @current_health = @max_health = opts.fetch(:max_health, 1)
      @attack_rating = opts.fetch(:attack_rating, 1)
      @defense_rating = opts.fetch(:defense_rating, 0)
    end

    def alive?
      current_health > 0
    end

    def dead?
      !alive?
    end

    def receive_damage!(damage = 1)
      @current_health = min_zero(current_health - damage)
    end

    private

    def min_zero(num)
      [num, 0].max
    end
  end
end
