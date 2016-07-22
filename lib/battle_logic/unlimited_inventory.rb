module BattleLogic
  class UnlimitedInventory
    def initialize
      @items = []
    end
    
    def <<(item)
      items << item
    end
    
    def contain?(item)
      items.include?(item)
    end
    
    private
    
    attr_accessor :items
  end
end
