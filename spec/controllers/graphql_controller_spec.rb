# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  describe "users" do
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

    before do
      post :execute, params: { query: query }
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns 'ok'" do
      expect(parsed_response_body).to eq(expected_response)
    end
  end
end
