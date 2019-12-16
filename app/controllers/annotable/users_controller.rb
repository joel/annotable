require_dependency 'annotable/application_controller'

module Annotable
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy].freeze

    class << self
      # Define which resources are the authorized to be included
      # @return [Array]
      def allowed_includes
        %i[organization].freeze
      end

      # Define which fields can be use as filters
      # @return [Array]
      def allowed_filterables
        %i[created_at updated_at organization_id name email].freeze
      end
    end

    # GET /users
    # @return [String] Json Response
    def index
      @users = User.all

      jsonapi_filter(@users, self.class.allowed_filterables) do |filtered_organizations|
        jsonapi_paginate(filtered_organizations.result) do |paginated_organizations|
          render jsonapi: paginated_organizations
        end
      end
    end

    # GET /users/<UUID>
    # @return [String] Json Response
    def show
      render jsonapi: @user
    end

    # POST /users
    # @return [String] Json Response
    def create
      @user = User.new(user_params)

      if @user.save
        render jsonapi: @user, status: :created, location: @user
      else
        render jsonapi_errors: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/<UUID>
    # @return [String] Json Response
    def update
      if @user.update(user_params)
        render jsonapi: @user
      else
        render jsonapi_errors: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/<UUID>
    # @return [String] Empty Body
    def destroy
      @user.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions
    # @return [[]]
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through
    # @return [ActionController::Parameters]
    def user_params
      jsonapi_deserialize(params, only: %i[name email organization_id])
    end
  end
end
