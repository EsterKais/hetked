# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Graphql: Profiles", type: :request do
  include_context "with authentication"

  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  let!(:profile) { create(:profile) }

  before do
    post "/graphql", params: { query: query }, headers: headers
  end

  context "when returning all" do
    let(:query) do
      "{\n\tprofiles {\nfirstname\nlastname\nusername\nuser {\nemail\n}\n}\n}"
    end

    let(:expected_response) do
      {
        data:
        {
          profiles:
          [
            {
              firstname: profile.firstname,
              lastname: profile.lastname,
              username: profile.username,
              user: {
                email: profile.user.email
              }
            }
          ]
        }
      }
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the expected response" do
      expect(parsed_response_body).to eq(expected_response)
    end
  end

  context "when filtering" do
    let(:firstname) { "someone" }
    let(:profile) { create(:profile, firstname: firstname) }

    let(:query) do
      "{\nprofiles(filter:{firstname:\"some\"}){\nfirstname\n}\n}\n"
    end

    let(:expected_response) do
      {
        data:
        {
          profiles:
          [
            {
              firstname: profile.firstname
            }
          ]
        }
      }
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the expected response" do
      expect(parsed_response_body).to eq(expected_response)
    end
  end

  # context "when creating" do
  #   let(:query) do
  #     "mutation {\ncreateUser(\nemail:\"#{email}\"\n){\nid\nemail\n}\n}"
  #   end

  #   it "returns status 200" do
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it "returns the anticipated body" do
  #     expect(
  #       parsed_response_body.dig(:data, :createUser, :email)
  #     ).to eq(email)
  #   end

  #   it "creates a new user" do
  #     expect(User.where(email: email).count).to eq(1)
  #   end
  # end

  # context "when updating" do
  #   let(:query) do
  #     "mutation {\nupdateUser(email: \"someone@email.com\") {\nemail\n}\n}\n"
  #   end

  #   it "returns status 200" do
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it "returns the anticipated body" do
  #     expect(
  #       parsed_response_body.dig(:data, :updateUser, :email)
  #     ).to eq(email)
  #   end

  #   it "updates the logged in user" do
  #     expect(User.where(email: email).count).to eq(1)
  #   end
  # end
end
