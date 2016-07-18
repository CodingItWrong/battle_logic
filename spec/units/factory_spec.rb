RSpec.describe BattleLogic::Factory do
  describe "#character" do
    let(:fields) {{
      max_health: 3,
      attack_rating: 2,
      defense_rating: 1,
    }}

    context "with no configured attack action" do
      let(:factory) { described_class.new }

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
  end
end
