require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe "<%= class_name.pluralize %>", <%= type_metatag(:request) %> do
  context 'with <%= class_name.underscore.pluralize %>' do
    let!(:<%= class_name.underscore %>) { Fabricate(:<%= class_name.underscore %>) }

    describe 'GET /<%= class_name.underscore.pluralize %>' do
      it 'should return the collections' do
        get(<%= class_name.underscore.pluralize %>_path)

        expect(response).to have_http_status(:ok)
        expect(response_json['data'].size).to eq(1)
        expect(response_json['data'].first).to have_id(<%= class_name.underscore %>.id)

<% for attribute in attributes -%>
        expect(response_json['data'].first)
          .to have_attribute(:<%= attribute.name %>).with_value(<%= class_name.underscore %>.<%= attribute.name %>)
<% end -%>
      end
    end

    describe 'GET /<%= class_name.underscore.pluralize %>/<UUID>' do
      it do
        get(<%= class_name.underscore %>_path(<%= class_name.underscore %>.id))

        expect(response).to have_http_status(:ok)
        expect(response_json['data']).to have_id(<%= class_name.underscore %>.id)
      end
    end

    describe 'DELETE /<%= class_name.underscore.pluralize %>/<UUID>' do
      it 'should properly delete the resource' do
        expect do
          delete(<%= class_name.underscore %>_path(<%= class_name.underscore %>.id))
        end.to change(<%= class_name.capitalize %>, :count).by(-1)

        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_blank
      end
    end

    describe 'PUT-PATCH /<%= class_name.underscore.pluralize %>/<UUID>' do
      let(:params) do
        { data: { attributes: param_attributes } }
      end

      context 'with valid params' do
        let(:param_attributes) { Fabricate.attributes_for(:<%= class_name.underscore %>) }

        it 'should update properly the resource' do
          expect do
            put(<%= class_name.underscore %>_path(<%= class_name.underscore %>.id), params: params)
          end.to change {
            <%= class_name.underscore %>.reload.<%= attributes.first.name %>
          }.from(<%= class_name.underscore %>.<%= attributes.first.name %>).to(param_attributes[:<%= attributes.first.name %>])

          expect(response).to have_http_status(:ok)

          expect(response_json['data']).to have_id(<%= class_name.underscore %>.id)
<% for attribute in attributes -%>
          expect(response_json['data'])
            .to have_attribute(:<%= attribute.name %>).with_value(param_attributes[:<%= attribute.name %>])
<% end -%>
        end
      end

      context 'with invalid params' do
        let(:param_attributes) { { <%= attributes.first.name %>: nil } }

        it 'should return the error message' do
          expect {
            put(<%= class_name.underscore %>_path(<%= class_name.underscore %>.id), params: params)
          }.not_to change(<%= class_name.underscore %>, :name)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_json['errors'][0]['detail']).to eql("<%= attributes.first.name.capitalize %> can't be blank")
        end
      end
    end
  end

  describe 'POST /<%= class_name.underscore.pluralize %>' do
    let(:params) do
      { data: { attributes: param_attributes } }
    end

    context 'with valid attributes' do
      let(:<%= class_name.underscore %>) { <%= class_name.capitalize %>.last }
      let(:param_attributes) do
        Fabricate.attributes_for(:<%= class_name.underscore %>)
      end

      it do
        expect do
          post(<%= class_name.underscore.pluralize %>_path, params: params)
        end.to change(<%= class_name.capitalize %>, :count).by(+1)

        expect(response).to have_http_status(:created)

        expect(response_json['data']).to have_id(<%= class_name.underscore %>.id)
<% for attribute in attributes -%>
          expect(response_json['data'])
            .to have_attribute(:<%= attribute.name %>).with_value(param_attributes[:<%= attribute.name %>])
<% end -%>
      end
    end

    context 'with invalid attributes' do
      let(:param_attributes) { { <%= attributes.first.name %>: nil } }

      it 'should return the error message' do
        expect do
          post(<%= class_name.underscore.pluralize %>_path, params: params)
        end.not_to change(<%= class_name.capitalize %>, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json['errors'][0]['detail']).to eql("<%= attributes.first.name.capitalize %> can't be blank")
      end
    end
  end

end
<% end -%>
