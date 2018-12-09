# frozen_string_literal: true

require "rails_helper"
require "jwt"

RSpec.describe ApplicationController, type: :request do
  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  describe ".authenticate_user!" do
    let(:expected_response) { { error: "Unauthorized" } }

    before { post "/graphql" }

    context "with JWT token provided" do
      let(:jwt_token) { JWT.encode(payload, nil, "none") }
      let(:headers) { { authentication: jwt_token } }

      context "with an email that doesn't exist" do
        let(:payload) { { email: "does@not.exist" } }

        it "returns status 401" do
          expect(response).to have_http_status(:unauthorized)
        end

        it "returns 'Unauthorized'" do
          expect(parsed_response_body).to eq(expected_response)
        end
      end

      context "with no email in the token" do
        let(:payload) { { something: "else" } }

        it "returns status 401" do
          expect(response).to have_http_status(:unauthorized)
        end

        it "returns 'Unauthorized'" do
          expect(parsed_response_body).to eq(expected_response)
        end
      end
    end

    context "with no authentication token in the header" do
      it "returns status 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns 'Unauthorized'" do
        expect(parsed_response_body).to eq(expected_response)
      end
    end
  end
end
