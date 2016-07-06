require "battle_logic"
require "spec_helper"

module BattleLogic
  RSpec.describe Character do
    it "is alive by default" do
      expect(subject).to be_alive
    end
  end
end
