RSpec.describe "using items" do
  let(:factory) { BattleLogic::Factory.new }
  
  it "can heal characters" do
    terra = factory.character
    edgar = factory.character(current_health: 100, max_health: 200)
    potion = BattleLogic::HealingItem.new(healing_amount:50)
    terra.use(potion, on: edgar)
    expect(edgar.current_health).to eq(150)
  end
end
