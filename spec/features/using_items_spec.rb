RSpec.describe 'using items' do
  let(:factory) { BattleLogic::Factory.new }


  it 'can heal characters' do
    terra = factory.character
    edgar = factory.character(current_health: 100, max_health: 200)
    potion = BattleLogic::HealingItem.new(healing_amount: 50)
    terra.inventory << potion
    terra.use(potion, on: edgar)
    expect(edgar.current_health).to eq(150)
  end

  it "must be in the user's inventory to be used" do
    terra = factory.character
    edgar = factory.character(current_health: 100, max_health: 200)
    potion = BattleLogic::HealingItem.new(healing_amount: 50)
    expect { terra.use(potion, on: edgar) }
      .to raise_error "item not in user's inventory"
  end

  it "is removed from the user's inventory when used" do
    terra = factory.character
    edgar = factory.character(current_health: 100, max_health: 200)
    potion = BattleLogic::HealingItem.new(healing_amount: 50)

    terra.inventory << potion
    expect(terra.inventory.contain?(potion)).to eq(true)
    terra.use(potion, on: edgar)
    expect(terra.inventory.contain?(potion)).to eq(false)
  end

  context 'shared inventory' do
    let(:factory) { BattleLogic::Factory.new(shared_inventory: true) }

    it 'makes items usable by all characters' do
      terra = factory.character
      edgar = factory.character
      potion = BattleLogic::HealingItem.new(healing_amount: 5)

      terra.inventory << potion
      expect { edgar.use(potion, on: edgar) }.to_not raise_error
    end
  end

end
