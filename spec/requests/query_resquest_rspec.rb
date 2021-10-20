require 'rails_helper'

RSpec.describe Api::V1::CepsController do
  describe 'Query API', type: :request do
    context 'context: general authentication via API, ' do
      it 'gives you an authentication code if you are an existing user and you satisfy the password' do
        login
        # puts "#{response.headers.inspect}"
        # puts "#{response.body.inspect}"
        expect(response.has_header?('access-token')).to eq(true)
      end

      it 'gives you a status 200 on signing in ' do
        login
        expect(response.status).to eq(200)
      end

      it 'deny access to a restricted page with an incorrect token' do
        login
        auth_params = response.headers.tap do |h|
          h.each do |k, _v|
            if k == 'access-token'
              h[k] = '123'
            end end
        end
        get_data
        expect(response).not_to have_http_status(:success)
      end
    end

    context 'context: API Response, ' do
      before do
        login
        get_data
      end

      it "Validating JSON body response" do
        expect(response.body).to include 'cep'
      end
    end
  end
end

def login
  VCR.use_cassette('requests/login') do
    post "/api/auth/sign_in", params: {  email:"admin@email.com", password:"123456" }
  end
end

def get_data
  VCR.use_cassette('requests/query_api') do
    get "/api/ceps/74560540", headers: { 'access-token' => response.headers['access-token'], :uid => response.headers['uid'], :client => response.headers['client'] }
  end
end