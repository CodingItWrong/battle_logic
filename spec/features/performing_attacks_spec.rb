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
end
