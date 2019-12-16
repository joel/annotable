require 'rails_helper'

module Annotable
  RSpec.describe User, type: :model do
    let(:user) { described_class.new(attributes) }

    context 'valid_attributes' do
      let(:valid_attributes) do
        Fabricate.attributes_for(:user)
      end
      let(:attributes) { valid_attributes }
      it { expect(user).to be_valid }
    end

    context 'invalid_attributes' do
      let(:invalid_attributes) do
        { email: 'not_an_email' }
      end
      let(:attributes) { invalid_attributes }
      it do
        expect(user).not_to be_valid
        expect(user.errors.messages).to eql(email: ['is invalid'])
      end
    end
  end
end
