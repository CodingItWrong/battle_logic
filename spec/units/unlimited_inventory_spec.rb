module BattleLogic
  RSpec.describe UnlimitedInventory do
    it 'can receive an item' do
      item = double('item')
      expect { subject << item }.to_not raise_error
    end

    it 'reports an item is in it if it has received it' do
      item = double('item')
      subject << item
      expect(subject.contain?(item)).to be_truthy
    end

    it 'can remove an item' do
      item = double('item')
      subject << item
      subject.remove(item)
      expect(subject.contain?(item)).to be_falsy
    end
  end
end
