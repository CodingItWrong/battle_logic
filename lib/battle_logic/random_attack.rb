module BattleLogic
  class RandomAttack
    MAX_DEFENSE_RATING = 256
    
    attr_reader :attacker, :defender

    def initialize(attacker:, defender:)
      @attacker = attacker
      @defender = defender
    end

    def perform
      defender.receive_damage!(damage)
    end

    private

    def damage
      (attack_damage * defense_modifier) + scratch_damage
    end

    def attack_modifier
      prng = Random.new
      prng.rand(0.9..1.0)
    end

    def attack_damage
      attacker.attack_rating * attack_modifier
    end

    def scratch_damage
      1
    end

    def defense_modifier
      (max_defense_rating.to_f - defender.defense_rating.to_f) / max_defense_rating.to_f
    end
    
    def max_defense_rating
      MAX_DEFENSE_RATING
    end
  end
end
