RSpec.shared_examples 'a Model with integer value validation' do |factory_name, property|
  describe "for #{property}" do
    let(:object1) { build factory_name, property => '5.1' }
    let(:object2) { build factory_name, property => -5.1 }

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
