RSpec.describe BattleLogic::Factory do
  let(:factory) { described_class.new }

  describe "#character" do
    let(:fields) {{
      max_health: 3,
      attack_rating: 2,
      defense_rating: 1,
    }}

    context "with no configured attack action" do
      subject(:character) { factory.character(fields) }

      it "constructs a character with passed-in fields" do
        aggregate_failures do
          fields.each_pair do |field, expected_value|
            value = character.public_send(field)
            expect(value).to eq(expected_value),
              "Expected #{field} to be #{expected_value}, was #{value}"
          end
        end
      end
      
      it "sets the attack action to SimpleAttack" do
        expect(character.attack_action).to eq(BattleLogic::SimpleAttack)
      end
    end
    
    context "with a configured attack action" do
      let(:attack) { double }
      let(:factory) { described_class.new(attack_action: attack) }

      subject(:character) { factory.character(fields) }

      it "sets the attack action to the configured attack" do
        expect(character.attack_action).to eq(attack)
      end
    end
    
    context "with no configured inventory" do
      subject(:character) { factory.character }

      it "sets the inventory to an instance of UnlimitedInventory" do
        expect(character.inventory).to be_kind_of(BattleLogic::UnlimitedInventory)
      end
    end
    
    context "with a configured inventory" do
      let(:inventory) { double("inventory") }
      let(:inventory_factory) { double("inventory_factory", new: inventory) }
      let(:factory) { described_class.new(inventory_factory: inventory_factory) }

      subject(:character) { factory.character }

      it "sets the inventory to the configured inventory" do
        expect(character.inventory).to eq(inventory)
      end
    end
  end
end
