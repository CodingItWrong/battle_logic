require "battle_logic"
require "spec_helper"

module BattleLogic
  RSpec.describe Character do
    it "has current health 1 by default" do
      expect(subject.current_health).to eq(1)
    end

    it "has max health 1 by default" do
      expect(subject.max_health).to eq(1)
    end

    it "can be configured with a max health" do
      subject = described_class.new(max_health:2)
      expect(subject.max_health).to eq(2)
    end

    it "defaults the current health to the max health" do
      subject = described_class.new(max_health:2)
      expect(subject.current_health).to eq(2)
    end

    it "is alive by default" do
      expect(subject).to be_alive
    end

    it "loses current health when it receives damage" do
      subject = described_class.new(max_health:3)
      subject.receive_damage!
      expect(subject.current_health).to eq(2)
    end

    it "cannot have current health less than zero" do
      subject = described_class.new(max_health:1)
      2.times { subject.receive_damage! }
      expect(subject.current_health).to eq(0)
    end

    it "can attack" do
      defender = instance_double(described_class)
      expect(defender).to receive(:receive_damage!)
      subject.attack(defender)
    end
  end
end
