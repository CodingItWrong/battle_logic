RSpec.describe BattleLogic::SimpleAttack do
  subject(:attack) { described_class.new(attacker: attacker,
                                         defender: defender) }

  context "no defense" do
    let(:attacker) { double(attack_rating: 2) }
    let(:defender) { double(defense_rating: 0) }
    
    it "deals damage equal to the attack rating" do
      expect(defender).to receive(:receive_damage!).with(2)
      attack.perform
    end
  end

  context "attack higher than defense" do
    let(:attacker) { double(attack_rating: 3) }
    let(:defender) { double(defense_rating: 2) }
    
    it "deals damage equal to attack rating - defense rating" do
      expect(defender).to receive(:receive_damage!).with(1)
      attack.perform
    end
  end

  context "defense higher than attack" do
    let(:attacker) { double(attack_rating: 2) }
    let(:defender) { double(defense_rating: 3) }
    
    it "deals zero damage" do
      expect(defender).to receive(:receive_damage!).with(0)
      attack.perform
    end
  end
end
