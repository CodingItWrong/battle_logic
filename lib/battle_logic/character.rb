module BattleLogic
  class Character
    attr_reader *%i(max_health current_health attack_rating defense_rating
                    attack_action)

    def initialize(opts = {})
      @current_health = @max_health = opts.fetch(:max_health, 1)
      @attack_rating = opts.fetch(:attack_rating, 1)
      @defense_rating = opts.fetch(:defense_rating, 0)
      @attack_action = opts.fetch(:attack_action, SimpleAttack)
    end

    def alive?
      current_health > 0
    end

    def dead?
      !alive?
    end

    def attack(defender)
      attack_action.new(attacker: self, defender: defender).perform
    end

    def receive_damage!(damage = 1)
      @current_health = min_zero(current_health - min_zero(damage))
    end

    private

    def min_zero(num)
      [num, 0].max
    end
  end
end
