module BattleLogic
  RSpec.describe Character do
    it_behaves_like "an attackable thing"
    it_behaves_like "a healable thing"

    it "has current health 1 by default" do
      expect(subject.current_health).to eq(1)
    end

    it "has max health 1 by default" do
      expect(subject.max_health).to eq(1)
    end

    it "has attack rating 1 by default" do
      expect(subject.attack_rating).to eq(1)
    end

    it "has defense rating 0 by default" do
      expect(subject.defense_rating).to eq(0)
    end

    it "can be configured with a max health" do
      subject = described_class.new(max_health:2)
      expect(subject.max_health).to eq(2)
    end

    it "defaults the current health to the max health" do
      subject = described_class.new(max_health:2)
      expect(subject.current_health).to eq(2)
    end

    it "can be configured with a current health less than the max health" do
      subject = described_class.new(max_health: 3, current_health: 1)
      expect(subject.current_health).to eq(1)
    end

    it "can be configured with an attack rating" do
      subject = described_class.new(attack_rating:2)
      expect(subject.attack_rating).to eq(2)
    end

    it "can be configured with a defense rating" do
      subject = described_class.new(defense_rating:1)
      expect(subject.defense_rating).to eq(1)
    end

    it "can be configured with an attack action" do
      attack = double("attack", perform:nil)
      attack_class = double("attack_class", new: attack)
      subject = described_class.new(attack_action:attack_class)
      defender = double("defender")

      subject.attack(defender)

      expect(attack_class).to have_received(:new).with(attacker: subject, defender: defender)
      expect(attack).to have_received(:perform)
    end

    it "is alive by default" do
      expect(subject).to be_alive
    end

    it "can attack" do
      subject = described_class.new(attack_rating:2)
      defender = double("defender", defense_rating: 1, receive_damage!: nil)
      subject.attack(defender)

      expect(defender).to have_received(:receive_damage!).with(1)
    end

    context "receiving damage" do
      it "loses current health when it receives damage" do
        subject = described_class.new(max_health:3)
        subject.receive_damage!
        expect(subject.current_health).to eq(2)
      end

      it "can be hit for multiple damage" do
        subject = described_class.new(max_health:3)
        subject.receive_damage!(2)
        expect(subject.current_health).to eq(1)
      end

      it "does not allow damage less than zero" do
        subject = described_class.new(max_health:3)
        subject.receive_damage!(-1)
        expect(subject.current_health).to eq(3)
      end

      it "cannot have current health less than zero" do
        subject = described_class.new(max_health:1)
        subject.receive_damage!(2)
        expect(subject.current_health).to eq(0)
      end
    end

    context "receiving healing" do
      it "gains health when it receives healing" do
        subject = described_class.new(max_health: 10, current_health: 5)
        subject.receive_healing!(2)
        expect(subject.current_health).to eq(7)
      end

      it "cannot gain more health than its max health" do
        subject = described_class.new(max_health: 10, current_health: 5)
        subject.receive_healing!(20)
        expect(subject.current_health).to eq(10)
      end

      it "cannot be healed a negative amount" do
        subject = described_class.new(max_health: 10, current_health: 5)
        subject.receive_healing!(-1)
        expect(subject.current_health).to eq(5)
      end
    end

    context "using items" do

      subject(:character) { described_class.new(use_item_action: use_item_class,
                                                inventory: inventory) }
      let(:use_item_class) { double("use item class", new: use_item) }
      let(:use_item) { double("use item", perform:nil) }
      let(:inventory) { double("inventory", contain?: true, remove: nil) }
      let(:item) { double("item") }
      let(:target) { double("target") }
      let(:use!) { subject.use(item, on: target) }

      it "can be configured with a use item action" do
        use!
        expect(use_item_class).to have_received(:new).with(item: item, target: target)
        expect(use_item).to have_received(:perform)
      end

      it "cannot use items not in the inventory" do
        allow(inventory).to receive(:contain?).and_return(false)
        expect{ use! }.to raise_error "item not in user's inventory"
      end

      it "removes items from the inventory when used" do
        use!
        expect(inventory).to have_received(:remove).with(item)
      end
    end
  end
end
