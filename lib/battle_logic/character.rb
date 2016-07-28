module BattleLogic
  class Character
    attr_reader(*%i(max_health current_health attack_rating defense_rating
                    attack_action use_item_action inventory))

    def initialize(opts = {})
      @max_health = opts.fetch(:max_health, 1)
      @current_health = opts.fetch(:current_health, max_health)
      @attack_rating = opts.fetch(:attack_rating, 1)
      @defense_rating = opts.fetch(:defense_rating, 0)
      @attack_action = opts.fetch(:attack_action, SimpleAttack)
      @use_item_action = opts.fetch(:use_item_action, UseItem)
      @inventory = opts.fetch(:inventory, UnlimitedInventory.new)
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

    def use(item, on:)
      raise "item not in user's inventory" unless inventory.contain?(item)
      use_item_action.new(item: item, target: on).perform
      inventory.remove(item)
    end

    def receive_damage!(damage = 1)
      @current_health = min_zero(current_health - min_zero(damage))
    end

    def receive_healing!(healing = 1)
      @current_health = max_max_health(current_health + min_zero(healing))
    end

    private

    def min_zero(num)
      [num, 0].max
    end

    def max_max_health(num)
      [num, max_health].min
    end
  end
end
