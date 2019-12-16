require 'rails_helper'

module Annotable
  RSpec.describe 'Organizations', type: :request do
    context 'with organizations' do
      let!(:organization) { Fabricate(:organization) }

      describe 'GET /organizations' do
        it 'should return the collections' do
          get(organizations_path)

          expect(response).to have_http_status(:ok)
          expect(response_json['data'].size).to eq(1)
          expect(response_json['data'].first).to have_id(organization.id)

          expect(response_json['data'].first)
            .to have_attribute(:name).with_value(organization.name)
        end
      end

      describe 'GET /organizations/<UUID>' do
        it do
          get(organization_path(organization.id))

          expect(response).to have_http_status(:ok)
          expect(response_json['data']).to have_id(organization.id)
        end
      end

      describe 'DELETE /organizations/<UUID>' do
        it 'should properly delete the resource' do
          expect do
            delete(organization_path(organization.id))
          end.to change(Organization, :count).by(-1)

          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_blank
        end
      end

      describe 'PUT-PATCH /organizations/<UUID>' do
        let(:params) do
          { data: { attributes: param_attributes } }
        end

        context 'with valid params' do
          let(:param_attributes) { Fabricate.attributes_for(:organization) }

          it 'should update properly the resource' do
            expect do
              put(organization_path(organization.id), params: params)
            end.to change {
              organization.reload.name
            }.from(organization.name).to(param_attributes[:name])

            expect(response).to have_http_status(:ok)

            expect(response_json['data']).to have_id(organization.id)
            expect(response_json['data'])
              .to have_attribute(:name).with_value(param_attributes[:name])
          end
        end

        context 'with invalid params' do
          let(:param_attributes) { { name: nil } }

          it 'should return the error message' do
            expect {
              put(organization_path(organization.id), params: params)
            }.not_to change(organization, :name)

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_json['errors'][0]['detail']).to eql("Name can't be blank")
          end
        end
      end
    end

    describe 'POST /organizations' do
      let(:params) do
        { data: { attributes: param_attributes } }
      end

      context 'with valid attributes' do
        let(:organization) { Organization.last }
        let(:param_attributes) do
          Fabricate.attributes_for(:organization)
        end

        it do
          expect do
            post(organizations_path, params: params)
          end.to change(Organization, :count).by(+1)

          expect(response).to have_http_status(:created)

          expect(response_json['data']).to have_id(organization.id)
          expect(response_json['data'])
            .to have_attribute(:name).with_value(param_attributes[:name])
        end
      end

      context 'with invalid attributes' do
        let(:param_attributes) { { name: nil } }

        it 'should return the error message' do
          expect do
            post(organizations_path, params: params)
          end.not_to change(Organization, :count)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_json['errors'][0]['detail']).to eql("Name can't be blank")
        end
      end
    end
  end
end
