module BattleLogic
  class Factory
    attr_reader :attack_action, :inventory_factory

    def initialize(params = {})
      @attack_action = params.fetch(:attack_action, nil)
      @inventory_factory = params.fetch(:inventory_factory, UnlimitedInventory)
    end
    
    def character(params = {})
      Character.new(params_with_defaults(params))
    end
    
    private
    
    def params_with_defaults(params)
      default_params.merge(params)
    end
    
    def default_params
      Hash.new.tap do |default_params|
        default_params[:inventory] = inventory
        default_params[:attack_action] = attack_action unless attack_action.nil?
      end
    end
    
    def inventory
      inventory_factory.new
    end
  end
end
