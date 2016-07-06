require "spec_helper"

RSpec.describe "performing attacks" do
  context "one-hit kills" do
    it "defaults characters to alive" do
      goomba = BattleLogic::Character.new
      expect(goomba).to be_alive
    end
  end
end
