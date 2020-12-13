require 'spec_helper'

RSpec.describe Adyen::ApiObject do
  let(:subclass) { Class.new(Adyen::ApiObject) }

  context 'private methods' do
    describe 'convert_to_hash_for_api' do
      subject { subclass.new(first_name: 'John', last_name: 'Doe') }

      before { subclass.attributes(:first_name, :last_name) }
      after  { subclass.attributes }

      it 'should return the proper Hash' do
        expect(subject.send(:convert_to_hash_for_api)).to eq('firstName' => 'John', 'lastName' => 'Doe')
      end
    end

    describe 'convert_to_hash_for_hpp' do
      subject do
        subclass.new(
          first_name:      'John',
          last_name:       'Doe',
          billing_address: {
            street:      'Main Street',
            city:        'Berlin',
            postal_code: '10178'
          }
        )
      end

      before { subclass.attributes(:first_name, :last_name, :billing_address) }
      after  { subclass.attributes }

      it 'should return the proper Hash' do
        expect(subject.send(:convert_to_hash_for_hpp)).to eq(
          'firstName'                 => 'John',
          'lastName'                  => 'Doe',
          'billingAddress.street'     => 'Main Street',
          'billingAddress.city'       => 'Berlin',
          'billingAddress.postalCode' => '10178'
        )
      end
    end
  end

  context 'class methods' do
    describe 'to_object' do
      let(:params) { { 'firstName' => 'John', 'lastName' => 'Doe' } }

      before { subclass.attributes(:first_name, :last_name) }
      after  { subclass.attributes }

      it 'should return a new ApiObject' do
        expect(subclass.to_object(params).first_name).to eq('John')
        expect(subclass.to_object(params).last_name).to eq('Doe')
      end
    end

    describe 'req_params' do
      let(:params) { { first_name: 'John', last_name: 'Doe' } }

      before { subclass.attributes(:first_name, :last_name) }
      after  { subclass.attributes }

      it 'should return a new ApiObject' do
        expect(subclass.req_params(params, :de).first_name).to eq('John')
        expect(subclass.req_params(params, :de).last_name).to eq('Doe')
      end
    end
  end
end
