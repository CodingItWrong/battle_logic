require "spec_helper"

RSpec.describe "performing attacks" do
  context "one-hit kills" do
    it "defaults characters to alive" do
      goomba = BattleLogic::Character.new
      expect(goomba).to be_alive
    end

    it "allows simple characters to be killed in one hit" do
      mario = BattleLogic::Character.new
      goomba = BattleLogic::Character.new
      mario.attack(goomba)
      expect(goomba).to be_dead
    end
  end

  context "multi-hit kills" do
    let(:mario) { BattleLogic::Character.new }
    let(:bowser) { BattleLogic::Character.new(max_health: 3) }

    it "does not kill the character after two hits" do
      2.times { mario.attack(bowser) }
      expect(bowser).to be_alive
    end

    it "kills the character after three hits" do
      3.times { mario.attack(bowser) }
      expect(bowser).to be_dead
    end
  end

  context "multiple points of damage" do
    let(:mario) { BattleLogic::Character.new(attack_rating: 2) }
    let(:bowser) { BattleLogic::Character.new(max_health: 3) }

    it "does not kill the character after one hit" do
      mario.attack(bowser)
      expect(bowser).to be_alive
    end

    it "kills the character after two hits" do
      2.times { mario.attack(bowser) }
      expect(bowser).to be_dead
    end
  end
end
