require 'rails_helper'

module Annotable
  RSpec.describe 'Reports', type: :request do
    let(:organization) { Fabricate(:organization) }

    context 'with reports' do
      let!(:report) { Fabricate(:report, organization: organization) }

      describe 'GET /reports' do
        it 'should return the collections' do
          get(organization_reports_path(organization))

          expect(response).to have_http_status(:ok)
          expect(response_json['data'].size).to eq(1)
          expect(response_json['data'].first).to have_id(report.id)

          expect(response_json['data'].first)
            .to have_attribute(:name).with_value(report.name)
          expect(response_json['data'].first)
            .to have_attribute(:content).with_value(report.content)
        end
      end

      describe 'GET /reports/<UUID>' do
        it do
          get(organization_report_path(organization, report.id))

          expect(response).to have_http_status(:ok)
          expect(response_json['data']).to have_id(report.id)
        end
      end

      describe 'DELETE /reports/<UUID>' do
        it 'should properly delete the resource' do
          expect do
            delete(organization_report_path(organization, report.id))
          end.to change(Report, :count).by(-1)

          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_blank
        end
      end

      describe 'PUT-PATCH /reports/<UUID>' do
        let(:params) do
          { data: { attributes: param_attributes } }
        end

        context 'with valid params' do
          let(:param_attributes) { Fabricate.attributes_for(:report) }

          it 'should update properly the resource' do
            expect do
              put(organization_report_path(organization, report.id), params: params)
            end.to change {
              report.reload.name
            }.from(report.name).to(param_attributes[:name])

            expect(response).to have_http_status(:ok)

            expect(response_json['data']).to have_id(report.id)
            expect(response_json['data'])
              .to have_attribute(:name).with_value(param_attributes[:name])
            expect(response_json['data'])
              .to have_attribute(:content).with_value(param_attributes[:content])
          end
        end

        context 'with invalid params' do
          let(:param_attributes) { { name: nil } }

          it 'should return the error message' do
            expect {
              put(organization_report_path(organization, report.id), params: params)
            }.not_to change(report, :name)

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_json['errors'][0]['detail']).to eql("Name can't be blank")
          end
        end
      end
    end

    describe 'POST /reports' do
      let(:params) do
        { data: { attributes: param_attributes } }
      end

      context 'with valid attributes' do
        let(:report) { organization.reports.last }
        let(:param_attributes) do
          Fabricate.attributes_for(:report).merge(organization_id: organization.id)
        end

        it do
          expect do
            post(organization_reports_path(organization), params: params)
          end.to change(Report, :count).by(+1)

          expect(response).to have_http_status(:created)

          expect(response_json['data']).to have_id(report.id)
          expect(response_json['data'])
            .to have_attribute(:name).with_value(param_attributes[:name])
          expect(response_json['data'])
            .to have_attribute(:content).with_value(param_attributes[:content])
          expect(response_json['data'])
            .to have_relationship(:organization)
            .with_data('id' => organization.id, 'type' => 'organization')
        end
      end

      context 'with invalid attributes' do
        let(:param_attributes) { { name: nil, organization_id: organization.id } }

        it 'should return the error message' do
          expect do
            post(organization_reports_path(organization), params: params)
          end.not_to change(Report, :count)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_json['errors'][0]['detail']).to eql("Name can't be blank")
        end
      end
    end
  end
end
