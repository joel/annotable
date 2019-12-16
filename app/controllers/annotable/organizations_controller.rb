require_dependency 'annotable/application_controller'

module Annotable
  class OrganizationsController < ApplicationController
    before_action :set_organization, only: %i[show update destroy]

    # GET /organizations
    # @return [String] Json Response
    def index
      @organizations = Organization.all

      render jsonapi: @organizations
    end

    # GET /organizations/<UUID>
    # @return [String] Json Response
    def show
      render jsonapi: @organization
    end

    # POST /organizations
    # @return [String] Json Response
    def create
      @organization = Organization.new(organization_params)

      if @organization.save
        render jsonapi: @organization, status: :created, location: @organization
      else
        render jsonapi_errors: @organization.errors, status: :unprocessable_entity
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
