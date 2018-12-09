# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  include_context "with authentication"

  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  before do
    post :execute, params: { query: query }
  end

  describe "users" do
    let(:email) { "someone@email.com" }

    context "when returning all" do
      let!(:user) { create(:user) }

      let(:query) do
        "{\nusers{\nid\nemail\n}\n}"
      end

      let(:expected_response) do
        {
          data:
          {
            users:
            [
              {
                email: user.email,
                id: user.id
              }
            ]
          }
        }
      end

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns 'ok'" do
        expect(parsed_response_body).to eq(expected_response)
      end
    end

    context "when filtering" do
      let!(:user) { create(:user, email: email) }

      let(:query) do
        "{\nusers(filter:{email:\"some\"}){\nid\nemail\n}\n}\n"
      end

      let(:expected_response) do
        {
          data:
          {
            users:
            [
              {
                email: user.email,
                id: user.id
              }
            ]
          }
        }
      end

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns 'ok'" do
        expect(parsed_response_body).to eq(expected_response)
      end
    end

    context "when creating" do
      let(:query) do
        "mutation {\ncreateUser(\nemail:\"#{email}\"\n){\nid\nemail\n}\n}"
      end

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the anticipated body" do
        expect(
          parsed_response_body.dig(:data, :createUser, :email)
        ).to eq(email)
      end

      it "creates a new user" do
        expect(User.where(email: email).count).to eq(1)
      end
    end
  end
end
