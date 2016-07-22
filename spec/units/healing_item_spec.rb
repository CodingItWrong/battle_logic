module BattleLogic
  RSpec.describe HealingItem do
    it "tells the target to receive healing" do
      target = double("target")
      item = described_class.new(healing_amount: 50)
      expect(target).to receive(:receive_healing!).with(50)
      
      item.use_on(target)
    end
  end
end
