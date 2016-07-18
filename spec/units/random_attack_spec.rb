RSpec.describe BattleLogic::RandomAttack do
  subject(:attack) { described_class.new(attacker: attacker,
                                         defender: defender) }
  let(:attacker) { double }
  let(:defender) { double }

  it_behaves_like "an action"

  # attack_rating * (0.9..1.0) * ((256-defense_rating) / 256) + 1

  context "similarly-leveled" do
    let(:attacker) { double(attack_rating: 150) }
    let(:defender) { double(defense_rating: 150) }

    it "deals random damage within a range" do
      10.times do
        expect(defender).to receive(:receive_damage!).with(a_value_between(56, 64))
        attack.perform
      end
    end
  end

  context "outleveled" do
    let(:attacker) { double(attack_rating: 150) }
    let(:defender) { double(defense_rating: 256) }

    it "deals one damage, not zero" do
      10.times do
        expect(defender).to receive(:receive_damage!).with(1)
        attack.perform
      end
    end
  end
end
