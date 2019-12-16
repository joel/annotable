require 'rails_helper'

module Annotable
  RSpec.describe OrganizationsController, type: :routing do
    describe 'routing' do
      context 'resource' do
        let(:id) { SecureRandom.uuid }

        it 'routes to #show' do
          expect(get: "/organizations/#{id}").to route_to('annotable/organizations#show', id: id.to_s)
        end
        it 'routes to #update via PUT' do
          expect(put: "/organizations/#{id}").to route_to('annotable/organizations#update', id: id.to_s)
        end

        it 'routes to #update via PATCH' do
          expect(patch: "/organizations/#{id}").to route_to('annotable/organizations#update', id: id.to_s)
        end

        it 'routes to #destroy' do
          expect(delete: "/organizations/#{id}").to route_to('annotable/organizations#destroy', id: id.to_s)
        end
      end

      it 'routes to #index' do
        expect(get: '/organizations').to route_to('annotable/organizations#index')
      end

      it 'routes to #create' do
        expect(post: '/organizations').to route_to('annotable/organizations#create')
      end
    end
  end
end
