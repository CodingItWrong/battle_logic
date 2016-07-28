module BattleLogic
  RSpec.describe UseItem do
    subject(:use_item) { described_class.new(item: item, target: target) }
    }
    let(:item) { double('item') }
    let(:target) { double('target') }

    it 'instructs the item to be used on the target' do
      expect(item).to receive(:use_on).with(target)
      use_item.perform
    end
  end
end
