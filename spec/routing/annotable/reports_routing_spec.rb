require 'rails_helper'

module Annotable
  RSpec.describe ReportsController, type: :routing do
    describe 'routing' do
      let(:org_id) { SecureRandom.uuid }

      context 'resource' do
        let(:id) { SecureRandom.uuid }

        it 'routes to #show' do
          expect(get: "/organizations/#{org_id}/reports/#{id}")
            .to route_to('annotable/reports#show', organization_id: org_id, id: id)
        end
        it 'routes to #update via PUT' do
          expect(put: "/organizations/#{org_id}/reports/#{id}")
            .to route_to('annotable/reports#update', organization_id: org_id, id: id)
        end

        it 'routes to #update via PATCH' do
          expect(patch: "/organizations/#{org_id}/reports/#{id}")
            .to route_to('annotable/reports#update', organization_id: org_id, id: id)
        end

        it 'routes to #destroy' do
          expect(delete: "/organizations/#{org_id}/reports/#{id}")
            .to route_to('annotable/reports#destroy', organization_id: org_id, id: id)
        end
      end

      it 'routes to #index' do
        expect(get: "/organizations/#{org_id}/reports")
          .to route_to('annotable/reports#index', organization_id: org_id)
      end

      it 'routes to #create' do
        expect(post: "/organizations/#{org_id}/reports")
          .to route_to('annotable/reports#create', organization_id: org_id)
      end
    end
  end
end
