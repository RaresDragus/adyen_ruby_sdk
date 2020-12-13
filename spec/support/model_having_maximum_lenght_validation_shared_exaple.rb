RSpec.shared_examples 'a Model with maximum length validation' do |factory_name, property, maximum_length|
  describe "for #{property}" do
    subject { build factory_name, property => 'a' * (maximum_length + 1) }

    before { subject.validate }

    it 'is not valid' do
      expect(subject).not_to be_valid
    end

    it 'has errors related to it' do
      expect(subject.errors).to include(property)
    end
  end
end
