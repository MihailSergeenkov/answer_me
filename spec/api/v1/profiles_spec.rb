require 'rails_helper'

describe 'Profile API' do
  let!(:me) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: me.id) }

  describe 'GET /me' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/me', { format: :json }.merge(options)
    end
  end

  describe 'GET /list' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let!(:users) { create_list(:user, 3) }

      before { get '/api/v1/profiles/list', format: :json, access_token: access_token.token }

      it "contains users json without me" do
        users.each do |user|
          expect(response.body).to include_json(user.to_json).at_path('profiles')
        end

        expect(response.body).to_not include_json(me.to_json).at_path('profiles')
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/list', { format: :json }.merge(options)
    end
  end
end
