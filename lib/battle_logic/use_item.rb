module BattleLogic
  class UseItem
    attr_reader :item, :target

    def initialize(item:, target:)
      @item = item
      @target = target
    end

    def perform
      item.use_on(target)
    end
  end
end
