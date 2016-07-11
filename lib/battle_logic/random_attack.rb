class RandomAttack
  def initialize(attacker:, defender:)
    @attacker = attacker
    @defender = defender
  end

  attr_reader :attacker, :defender

  def perform
    defender.receive_damage!(damage_after_defense)
  end

  private

  def damage_after_defense
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
    (256.0 - defender.defense_rating) / 256.0
  end
end
