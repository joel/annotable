<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]

  # GET <%= route_url %>
  # @return [String] Json Response
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>

    render jsonapi: <%= "@#{plural_table_name}" %>
  end

  # GET <%= route_url %>/<UUID>
  # @return [String] Json Response
  def show
    render jsonapi: <%= "@#{singular_table_name}" %>
  end

  # POST <%= route_url %>
  # @return [String] Json Response
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      render jsonapi: <%= "@#{singular_table_name}" %>, status: :created, location: <%= "@#{singular_table_name}" %>
    else
      render jsonapi_errors: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity
    end
  end

  # PATCH/PUT <%= route_url %>/<UUID>
  # @return [String] Json Response
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      render jsonapi: <%= "@#{singular_table_name}" %>
    else
      render jsonapi_errors: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity
    end
  end

  # DELETE <%= route_url %>/<UUID>
  # @return [String] Empty Body
  def destroy
    @<%= orm_instance.destroy %>
  end

  private
    # Use callbacks to share common setup or constraints between actions
    # @return [<%= class_path %>]
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through
    # @return [ActionController::Parameters]
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      jsonapi_deserialize(params, only: [])
      <%- else -%>
      jsonapi_deserialize(params, only: [<%= permitted_params %>])
      <%- end -%>
    end
end
<% end -%>
