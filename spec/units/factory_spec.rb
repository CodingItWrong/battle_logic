RSpec.describe BattleLogic::Factory do
  let(:factory) { described_class.new }

  describe '#character' do
    let(:fields) do
      {
        max_health: 3,
        attack_rating: 2,
        defense_rating: 1,
      }
    end

    context 'with no configured attack action' do
      subject(:character) { factory.character(fields) }

      it 'constructs a character with passed-in fields' do
        aggregate_failures do
          fields.each_pair do |field, expected_value|
            value = character.public_send(field)
            expect(value).to eq(expected_value),
              "Expected #{field} to be #{expected_value}, was #{value}"
          end
        end
      end

      it 'sets the attack action to SimpleAttack' do
        expect(character.attack_action).to eq(BattleLogic::SimpleAttack)
      end
    end

    context 'with a configured attack action' do
      let(:attack) { double }
      let(:factory) { described_class.new(attack_action: attack) }

      subject(:character) { factory.character(fields) }

      it 'sets the attack action to the configured attack' do
        expect(character.attack_action).to eq(attack)
      end
    end

    context 'with no configured inventory' do
      subject(:character) { factory.character }

      it 'sets the inventory to an instance of UnlimitedInventory' do
        expect(character.inventory)
          .to be_kind_of(BattleLogic::UnlimitedInventory)
      end
    end

    context 'with a configured inventory' do
      let(:inventory) { double('inventory') }
      let(:inventory_factory) { double('inventory_factory', new: inventory) }
      let(:factory) do
        described_class.new(inventory_factory: inventory_factory)
      end

      subject(:character) { factory.character }

      it 'sets the inventory to the configured inventory' do
        expect(character.inventory).to eq(inventory)
      end
    end

    context 'shared inventory' do
      let(:inventory1) { double('inventory1') }
      let(:inventory2) { double('inventory2') }
      let(:inventory_factory) { double('inventory_factory') }

      let(:character1) { factory.character }
      let(:character2) { factory.character }

      context 'not configured for shared inventory' do
        let(:factory) do
          described_class.new(inventory_factory: inventory_factory)
        end

        it 'uses a different inventory for all characters' do
          allow(inventory_factory).to receive(:new)
            .and_return(inventory1, inventory2)

          expect(character1.inventory).to eq(inventory1)
          expect(character2.inventory).to eq(inventory2)
        end
      end

      context 'configured for shared inventory' do
        let(:factory) do
          described_class.new(inventory_factory: inventory_factory,
                              shared_inventory: true)
        end

        it 'uses the same inventory for all characters' do
          allow(inventory_factory).to receive(:new)
            .and_return(inventory1, inventory2)

          expect(character1.inventory).to eq(inventory1)
          expect(character2.inventory).to eq(inventory1)
        end
      end
    end
  end
end
