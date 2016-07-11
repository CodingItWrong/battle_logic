require "spec_helper"

RSpec.describe "performing attacks" do
  context "one-hit kills" do
    it "defaults characters to alive" do
      goomba = BattleLogic::Character.new
      expect(goomba).to be_alive
    end

    it "allows simple characters to be killed in one hit" do
      mario = BattleLogic::Character.new
      goomba = BattleLogic::Character.new
      mario.attack(goomba)
      expect(goomba).to be_dead
    end
  end

  context "multi-hit kills" do
    let(:mario) { BattleLogic::Character.new }
    let(:bowser) { BattleLogic::Character.new(max_health: 3) }

    it "does not kill the character after two hits" do
      2.times { mario.attack(bowser) }
      expect(bowser).to be_alive
    end

    it "kills the character after three hits" do
      3.times { mario.attack(bowser) }
      expect(bowser).to be_dead
    end
  end

  context "multiple points of damage" do
    let(:mario) { BattleLogic::Character.new(attack_rating: 2) }
    let(:bowser) { BattleLogic::Character.new(max_health: 3) }

    it "does not kill the character after one hit" do
      mario.attack(bowser)
      expect(bowser).to be_alive
    end

    it "kills the character after two hits" do
      2.times { mario.attack(bowser) }
      expect(bowser).to be_dead
    end
  end

  context "defense" do
    let(:mario) { BattleLogic::Character.new(attack_rating: 2) }
    let(:bowser) { BattleLogic::Character.new(max_health: 3, defense_rating: 1) }

    it "does not kill the character after two hits" do
      2.times { mario.attack(bowser) }
      expect(bowser).to be_alive
    end

    it "kills the character after three hits" do
      3.times { mario.attack(bowser) }
      expect(bowser).to be_dead
    end
  end

  # attack_rating * (0.9..1.0) * ((255-defense_rating) / 256) + 1
  context "random damage algorithm" do
    context "similarly-leveled" do
      let(:terra) { BattleLogic::Character.new(attack_rating: 150) }
      let(:kefka) { BattleLogic::Character.new(defense_rating: 150, max_health: 9999) }

      it "random damage within a range" do
        10.times do
          expect {
            terra.attack(kefka)
          }.to change { kefka.current_health }.by( a_value_between(-63, -56) )
        end
      end
    end

    context "outleveled" do
      let(:terra) { BattleLogic::Character.new(attack_rating: 150) }
      let(:kefka) { BattleLogic::Character.new(defense_rating: 255, max_health: 9999) }

      it "does 1 damage, not 0" do
        10.times do
          expect {
            terra.attack(kefka)
          }.to change { kefka.current_health }.by(-1)
        end
      end
    end
  end
end
