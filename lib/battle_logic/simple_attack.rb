class SimpleAttack
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
    damage = attacker.attack_rating
    min_zero(damage - defender.defense_rating)
  end

  def min_zero(num)
    [num, 0].max
  end
end
