# frozen_string_literal: true

require "rails_helper"

RSpec.describe StatusController, type: :controller do
  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  describe "GET /status" do
    before { get :show }

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns 'ok'" do
      expect(parsed_response_body).to eq(status: "ok")
    end
  end
end
