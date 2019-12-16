require 'rails_helper'

module Annotable
  RSpec.describe 'Users', type: :request do
    context 'with users' do
      let!(:user) { Fabricate(:user) }

      describe 'GET /users' do
        it 'should return the collections' do
          get(users_path)

          expect(response).to have_http_status(:ok)
          expect(response_json['data'].size).to eq(1)
          expect(response_json['data'].first).to have_id(user.id)

          expect(response_json['data'].first)
            .to have_attribute(:name).with_value(user.name)
          expect(response_json['data'].first)
            .to have_attribute(:email).with_value(user.email)
        end
      end

      describe 'GET /users/<UUID>' do
        it do
          get(user_path(user.id))

          expect(response).to have_http_status(:ok)
          expect(response_json['data']).to have_id(user.id)
        end
      end

      describe 'DELETE /users/<UUID>' do
        it 'should properly delete the resource' do
          expect do
            delete(user_path(user.id))
          end.to change(User, :count).by(-1)

          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_blank
        end
      end

      describe 'PUT-PATCH /users/<UUID>' do
        let(:params) do
          { data: { attributes: param_attributes } }
        end

        context 'with valid params' do
          let(:param_attributes) { Fabricate.attributes_for(:user) }

          it 'should update properly the resource' do
            expect do
              put(user_path(user.id), params: params)
            end.to change {
              user.reload.name
            }.from(user.name).to(param_attributes[:name])

            expect(response).to have_http_status(:ok)

            expect(response_json['data']).to have_id(user.id)
            expect(response_json['data'])
              .to have_attribute(:name).with_value(param_attributes[:name])
            expect(response_json['data'])
              .to have_attribute(:email).with_value(param_attributes[:email])
          end
        end

        context 'with invalid params' do
          let(:param_attributes) { { email: nil } }

          it 'should return the error message' do
            expect {
              put(user_path(user.id), params: params)
            }.not_to change(user, :email)

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_json['errors'][0]['detail']).to eql("Email can't be blank")
          end
        end
      end
    end

    describe 'POST /users' do
      let(:params) do
        { data: { attributes: param_attributes } }
      end

      context 'with valid attributes' do
        let(:user) { User.last }
        let(:param_attributes) do
          Fabricate.attributes_for(:user)
        end

        it do
          expect do
            post(users_path, params: params)
          end.to change(User, :count).by(+1)

          expect(response).to have_http_status(:created)

          expect(response_json['data']).to have_id(user.id)
          expect(response_json['data'])
            .to have_attribute(:name).with_value(param_attributes[:name])
          expect(response_json['data'])
            .to have_attribute(:email).with_value(param_attributes[:email])
        end
      end

      context 'with invalid attributes' do
        let(:param_attributes) do
          Fabricate.attributes_for(:user).merge(email: 'not_an_email')
        end

        it 'should return the error message' do
          expect do
            post(users_path, params: params)
          end.not_to change(User, :count)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_json['errors'][0]['detail']).to eql('Email is invalid')
        end
      end
    end
  end
end
