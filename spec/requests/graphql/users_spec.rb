# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Graphql: Users", type: :request do
  include_context "with authentication"

  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  let(:custom_email) { Faker::Internet.email }

  before do
    post "/graphql", params: { query: query }, headers: headers
  end

  context "when returning all" do
    let(:query) do
      <<~HEREDOC
        {
          users {
            id
            email
          }
        }
      HEREDOC
    end

    let(:expected_response) do
      {
        data:
        {
          users:
          [
            {
              email: current_user.email,
              id: current_user.id
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
    let!(:user) { create(:user, email: custom_email) }

    let(:query) do
      <<~HEREDOC
        {
          users(
            filter: { email: "#{custom_email.split("@").first}" }
          ){
            id
            email
          }
        }
      HEREDOC
    end

    let(:expected_response) do
      {
        data:
        {
          users:
          [
            {
              email: custom_email,
              id: user.id
            }
          ]
        }
      }
    end

    before do
      post "/graphql", params: { query: query }, headers: headers
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the expected response" do
      expect(parsed_response_body).to eq(expected_response)
    end
  end

  context "when creating" do
    let(:query) do
      <<~HEREDOC
        mutation {
          createUser(
          email: "#{custom_email}"){
            id
            email
          }
        }
      HEREDOC
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the anticipated body" do
      expect(
        parsed_response_body.dig(:data, :createUser, :email)
      ).to eq(custom_email)
    end

    it "creates a new user" do
      expect(User.where(email: custom_email).count).to eq(1)
    end
  end

  context "when updating" do
    let(:query) do
      <<~HEREDOC
        mutation {
          updateUser(
          email: "#{custom_email}"){
            email
          }
        }
      HEREDOC
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the expected body" do
      expect(
        parsed_response_body.dig(:data, :updateUser, :email)
      ).to eq(custom_email)
    end

    it "updates the logged in user" do
      expect(User.where(email: custom_email).count).to eq(1)
    end
  end
end
