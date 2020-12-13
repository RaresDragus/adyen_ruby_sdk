RSpec.shared_examples 'a Model with inclusion validation' do |factory_name, property, values|
  describe "for #{property}" do
    let(:invalid) { build factory_name, property => 'other value' }

    values.each do |value|
      subject { build factory_name, property => value }

      before  do
        subject.validate
        invalid.validate
      end

      it "is valid with #{value} value" do
        expect(subject).to be_valid
      end
    end

    it 'is not valid with other value' do
      expect(invalid).not_to be_valid
    end

    it 'has errors related to it' do
      expect(invalid.errors).to include(property)
    end
  end
end
