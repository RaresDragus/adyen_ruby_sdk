RSpec.shared_examples 'a Model with range length validation' do |factory_name, property, first_value, second_value|
  describe "for #{property}" do
    let(:object1) { build factory_name, property => 'a' * (first_value - 1) }
    let(:object2) { build factory_name, property => 'a' * (second_value + 1) }

    before do
      object1.validate
      object2.validate
    end

    it 'is not valid' do
      expect(object1).not_to be_valid
      expect(object2).not_to be_valid
    end

    it 'has errors related to it' do
      expect(object1.errors).to include(property)
      expect(object2.errors).to include(property)
    end
  end
end
