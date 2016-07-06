require "battle_logic"
require "spec_helper"

module BattleLogic
  RSpec.describe Character do
    it "is alive by default" do
      expect(subject).to be_alive
    end

    it "can be killed" do
      subject.kill!
      expect(subject).to be_dead
    end

    it "can attack" do
      defender = instance_double(described_class)

      expect(defender).to receive(:kill!)
      subject.attack(defender)
    end
  end
end
