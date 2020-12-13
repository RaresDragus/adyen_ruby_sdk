RSpec.shared_examples 'a Model with factory' do |factory_name, attributes|
  it 'has factory' do
    expect { build(factory_name) }.not_to raise_error
  end

  it 'factory builds valid mocks' do
    expect(build(factory_name)).to be_valid
  end

  it 'factory knows the attributes' do
    expect(attributes_for(factory_name)).to include(*attributes)
  end
end
