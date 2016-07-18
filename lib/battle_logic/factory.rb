module BattleLogic
  class Factory
    attr_reader :attack_action

    def initialize(attack_action: nil)
      @attack_action = attack_action
    end
    
    def character(params = {})
      Character.new(params_with_defaults(params))
    end
    
    private
    
    def params_with_defaults(params)
      default_params.merge(params)
    end
    
    def default_params
      if @default_params.nil?
        @default_params = {}
        @default_params[:attack_action] = attack_action unless attack_action.nil?
      end
      @default_params
    end
  end
end
