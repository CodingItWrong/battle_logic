RSpec.shared_examples 'a healable thing' do
  it { is_expected.to respond_to(:receive_healing!) }
end
