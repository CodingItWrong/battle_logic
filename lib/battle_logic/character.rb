module BattleLogic
  class Character
    def initialize
      @alive = true
    end

    def alive?
      @alive
    end

    def dead?
      !alive?
    end

    def kill!
      @alive = false
    end

    def attack(defender)
      defender.kill!
    end
  end
end
