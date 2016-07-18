RSpec.shared_examples "an attackable thing" do
  it { is_expected.to respond_to(:receive_damage!) }
end
