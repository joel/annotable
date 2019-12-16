require_dependency 'annotable/application_controller'

module Annotable
  class OrganizationsController < ApplicationController
    before_action :set_organization, only: %i[show update destroy].freeze

    class << self
      # Define which resources are the authorized to be included
      # @return [Array]
      def allowed_includes
        [:users].freeze
      end

      # Define which fields can be use as filters
      # @return [Array]
      def allowed_filterables
        %i[created_at updated_at name].freeze
      end
    end

    # GET /organizations
    # @return [String] Json Response
    def index
      organizations = Organization.all

      jsonapi_filter(organizations, self.class.allowed_filterables) do |filtered_organizations|
        jsonapi_paginate(filtered_organizations.result) do |paginated_organizations|
          render jsonapi: paginated_organizations
        end
      end
    end

    # GET /organizations/<UUID>
    # @return [String] Json Response
    def show
      render jsonapi: @organization
    end

    # POST /organizations
    # @return [String] Json Response
    def create
      organization = Organization.new(organization_params)

      if organization.save
        render jsonapi: organization, status: :created, location: organization
      else
        render jsonapi_errors: organization.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /organizations/<UUID>
    # @return [String] Json Response
    def update
      if @organization.update(organization_params)
        render jsonapi: @organization
      else
        render jsonapi_errors: @organization.errors, status: :unprocessable_entity
      end
    end

    # DELETE /organizations/<UUID>
    # @return [String] Empty Body
    def destroy
      @organization.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions
    # @return [[]]
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through
    # @return [ActionController::Parameters]
    def organization_params
      jsonapi_deserialize(params, only: [:name])
    end
  end
end
