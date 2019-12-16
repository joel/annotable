require 'rails_helper'

module Annotable
  RSpec.describe Organization, type: :model do
    let(:organization) { described_class.new attributes }

    context 'valid_attributes' do
      let(:valid_attributes) do
        Fabricate.attributes_for(:organization)
      end
      let(:attributes) { valid_attributes }
      it { expect(organization).to be_valid }
    end

    context 'invalid_attributes' do
      let(:invalid_attributes) do
        { name: nil }
      end
      let(:attributes) { invalid_attributes }
      it do
        expect(organization).not_to be_valid
        expect(organization.errors.messages).to eql(name: ["can't be blank"])
      end
    end
  end
end
