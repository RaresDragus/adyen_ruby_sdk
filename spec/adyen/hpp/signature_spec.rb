require 'spec_helper'

RSpec.describe Adyen::Hpp::Signature do
  let(:params) do
    {
      'shopperLocale'     => 'de_DE',
      'merchantReference' => 'paymentTest:143522\64\39255',
      'sessionValidity'   => '2018-07-25T10:31:06Z',
      'shipBefore'        => '2018-07-30',
      'paymentAmount'     => '1995',
      'currencyCode'      => 'EUR'
    }
  end

  context 'private method' do
    describe 'escape_value' do
      it 'should return the correct value' do
        expect(described_class.send(:escape_value, params['sessionValidity'])).to eq('2018-07-25T10\:31\:06Z')
      end
    end

    describe 'sort_values' do
      it 'should return the correct result' do
        expect(described_class.send(:sort_values, params)).to eq(
          %w[EUR paymentTest:143522\64\39255 1995 2018-07-25T10:31:06Z 2018-07-30 de_DE]
        )
      end
    end

    describe 'sort_keys' do
      it 'should return the correct result' do
        expect(described_class.send(:sort_keys, params)).to eq(
          %w[currencyCode merchantReference paymentAmount sessionValidity shipBefore shopperLocale]
        )
      end
    end

    describe 'custom_sort_hash' do
      it 'should return the correct result' do
        expect(described_class.send(:custom_sort_hash, params)).to eq(
          %w[currencyCode merchantReference paymentAmount sessionValidity shipBefore shopperLocale
             EUR paymentTest:143522\64\39255 1995 2018-07-25T10:31:06Z 2018-07-30 de_DE]
        )
      end
    end

    describe 'custom_string' do
      it 'should return the correct result' do
        expect(described_class.send(:custom_string, params)).to eq(
          'currencyCode:merchantReference:paymentAmount:sessionValidity:shipBefore:shopperLocale:'\
          'EUR:paymentTest\\:143522\\64\\39255:1995:2018-07-25T10\\:31\\:06Z:2018-07-30:de_DE'
        )
      end
    end

    describe 'merchant_signature' do
      it 'should return the correct result' do
        expect(described_class.send(:merchant_signature, params)).to eq(
          'jufZSeiL8f8Gp5SHuPgyrn0UeTsWFY2/brkPjhj/UfA='
        )
      end
    end
  end
end
