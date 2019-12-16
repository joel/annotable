require 'rails_helper'

module Annotable
  RSpec.describe UsersController, type: :routing do
    describe 'routing' do
      context 'resource' do
        let(:id) { SecureRandom.uuid }

        it 'routes to #show' do
          expect(get: "/users/#{id}").to route_to('annotable/users#show', id: id.to_s)
        end
        it 'routes to #update via PUT' do
          expect(put: "/users/#{id}").to route_to('annotable/users#update', id: id.to_s)
        end

        it 'routes to #update via PATCH' do
          expect(patch: "/users/#{id}").to route_to('annotable/users#update', id: id.to_s)
        end

        it 'routes to #destroy' do
          expect(delete: "/users/#{id}").to route_to('annotable/users#destroy', id: id.to_s)
        end
      end

      it 'routes to #index' do
        expect(get: '/users').to route_to('annotable/users#index')
      end

      it 'routes to #create' do
        expect(post: '/users').to route_to('annotable/users#create')
      end
    end
  end
end
