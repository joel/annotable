require 'rails_helper'

module Annotable
  RSpec.describe Report, type: :model do
    let(:organization) { Fabricate(:organization) }
    let(:report) { described_class.new(attributes.merge(organization: organization)) }

    context 'valid_attributes' do
      let(:valid_attributes) do
        Fabricate.attributes_for(:report)
      end
      let(:attributes) { valid_attributes }
      it { expect(report).to be_valid }
    end

    context 'invalid_attributes' do
      let(:invalid_attributes) do
        { name: nil }
      end
      let(:attributes) { invalid_attributes }
      it do
        expect(report).not_to be_valid
        expect(report.errors.messages).to eql(name: ["can't be blank"])
      end
    end
  end
end
