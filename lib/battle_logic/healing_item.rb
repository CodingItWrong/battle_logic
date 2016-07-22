module BattleLogic
  class HealingItem
    attr_reader :healing_amount
    
    def initialize(healing_amount:)
      @healing_amount = healing_amount
    end
    
    def use_on(target)
      target.receive_healing!(healing_amount)
    end
  end
end
