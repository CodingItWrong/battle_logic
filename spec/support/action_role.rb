RSpec.shared_examples "an action" do
  it { is_expected.to respond_to(:perform) }
end
