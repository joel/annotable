require_dependency 'annotable/application_controller'

module Annotable
  class ReportsController < ApplicationController
    before_action :organization
    before_action :set_report, only: %i[show update destroy].freeze

    class << self
      # Define which resources are the authorized to be included
      # @return [Array]
      def allowed_includes
        %i[organization].freeze
      end

      # Define which fields can be use as filters
      # @return [Array]
      def allowed_filterables
        %i[created_at updated_at organization_id title content].freeze
      end
    end

    # GET /reports
    # @return [String] Json Response
    def index
      reports = @organization.reports.all

      jsonapi_filter(reports, self.class.allowed_filterables) do |filtered_organizations|
        jsonapi_paginate(filtered_organizations.result) do |paginated_organizations|
          render jsonapi: paginated_organizations
        end
      end
    end

    # GET /reports/<UUID>
    # @return [String] Json Response
    def show
      render jsonapi: @report
    end

    # POST /reports
    # @return [String] Json Response
    def create
      report = @organization.reports.build(report_params)

      if report.save
        render jsonapi: report, status: :created, location: organization_report_url(@organization, report)
      else
        render jsonapi_errors: report.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /reports/<UUID>
    # @return [String] Json Response
    def update
      if @report.update(report_params)
        render jsonapi: @report
      else
        render jsonapi_errors: @report.errors, status: :unprocessable_entity
      end
    end

    # DELETE /reports/<UUID>
    # @return [String] Empty Body
    def destroy
      @report.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions
    # @return [[]]
    def set_report
      @report = @organization.reports.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through
    # @return [ActionController::Parameters]
    def report_params
      jsonapi_deserialize(params, only: %i[name content organization_id])
    end

    # Scope to the Annotable::Organization
    # @return [Annotable::Organization]
    def organization
      @organization = Organization.find(params.require(:organization_id))
    end
  end
end
