RSpec.shared_examples 'a Model with required properties' do |factory_name, properties|
  properties.each do |property|
    describe "without #{property}" do
      subject { build factory_name, property => nil }

      before  { subject.validate }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end

      it 'has errors related to it' do
        expect(subject.errors).to include(property)
      end
    end
  end
end
