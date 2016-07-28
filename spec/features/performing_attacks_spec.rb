RSpec.describe 'performing attacks' do
  context 'direct damage algorithm' do
    let(:factory) { BattleLogic::Factory.new }

    context 'one-hit kills' do
      it 'allows simple characters to be killed in one hit' do
        mario = factory.character
        goomba = factory.character
        mario.attack(goomba)
        expect(goomba).to be_dead
      end
    end

    context 'multi-hit kills' do
      let(:mario) { factory.character }
      let(:bowser) { factory.character(max_health: 3) }

      it 'does not kill the character after two hits' do
        2.times { mario.attack(bowser) }
        expect(bowser).to be_alive
      end

      it 'kills the character after three hits' do
        3.times { mario.attack(bowser) }
        expect(bowser).to be_dead
      end
    end

    context 'multiple points of damage' do
      let(:mario) { factory.character(attack_rating: 2) }
      let(:bowser) { factory.character(max_health: 3) }

      it 'does not kill the character after one hit' do
        mario.attack(bowser)
        expect(bowser).to be_alive
      end

      it 'kills the character after two hits' do
        2.times { mario.attack(bowser) }
        expect(bowser).to be_dead
      end
    end

    context 'defense' do
      let(:mario) { factory.character(attack_rating: 2) }
      let(:bowser) { factory.character(max_health: 3, defense_rating: 1) }

      it 'does not kill the character after two hits' do
        2.times { mario.attack(bowser) }
        expect(bowser).to be_alive
      end

      it 'kills the character after three hits' do
        3.times { mario.attack(bowser) }
        expect(bowser).to be_dead
      end
    end
  end

  context 'random damage algorithm' do

    let(:factory) { BattleLogic::Factory.new(attack_action: BattleLogic::RandomAttack) }

    context 'similarly-leveled' do
      let(:terra) { factory.character(attack_rating: 150) }
      let(:kefka) { factory.character(defense_rating: 150, max_health: 9999) }

      it 'random damage within a range' do
        10.times do
          expect {
            terra.attack(kefka)
          }.to change { kefka.current_health }.by( a_value_between(-64, -56) )
        end
      end
    end
  end
end
