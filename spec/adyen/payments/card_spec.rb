require 'spec_helper'

RSpec.describe Adyen::Payments::Card, type: :model do
  it_behaves_like 'a Model with factory', :card, %i[cvc expiry_month expiry_year holder_name number]
  it_behaves_like 'a Model with required properties', :card, %i[expiry_month expiry_year holder_name number]
  it_behaves_like 'a Model with fixed length validation', :card, :expiry_month, 2
  it_behaves_like 'a Model with fixed length validation', :card, :expiry_year, 4
  it_behaves_like 'a Model with range length validation', :card, :cvc, 1, 20
  it_behaves_like 'a Model with range length validation', :card, :number, 4, 19

  describe 'encode' do
    subject { build :card }

    it 'is a Hash' do
      expect(subject.encode).to be_a(Hash)
    end

    it 'has one element' do
      expect(subject.encode.size).to eq(1)
    end

    it "has 'card.encrypted.json' key" do
      expect(subject.encode.keys.first).to eq('card.encrypted.json')
    end
  end
end
