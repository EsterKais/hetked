# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Graphql: Profiles", type: :request do
  include_context "with authentication"

  subject(:parsed_response_body) do
    JSON.parse(response.body).deep_symbolize_keys
  end

  let!(:profile) { create(:profile, user: current_user) }

  before do
    post "/graphql", params: { query: query }, headers: headers
  end

  context "when returning all" do
    let(:query) do
      <<~HEREDOC
        {
          profiles {
            firstname
            lastname
            username
            user {
              email
            }
          }
        }
      HEREDOC
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
      <<~HEREDOC
        {
          profiles(
            filter: {
              firstname: "some"
            }
          ){
            firstname
          }
        }
      HEREDOC
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

  context "when creating" do
    let(:firstname) { Faker::Artist.name }
    let(:lastname) { Faker::Artist.name }
    let(:username) { Faker::Artist.name }

    let(:query) do
      <<~HEREDOC
        mutation {
          createProfile(
            firstname: "#{firstname}",
            lastname: "#{lastname}",
            username: "#{username}"
          ){
            firstname
            lastname
            username
            user {
              email
            }
          }
        }
      HEREDOC
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the anticipated body" do
      expect(
        parsed_response_body.dig(:data, :createProfile, :firstname)
      ).to eq(firstname)
    end

    it "creates the profile for the logged in user" do
      expect(
        parsed_response_body.dig(:data, :createProfile, :user, :email)
      ).to eq(current_user.email)
    end

    it "creates a new user" do
      expect(Profile.where(firstname: firstname).count).to eq(1)
    end
  end

  context "when updating" do
    let(:firstname) { Faker::Artist.name }

    let(:query) do
      <<~HEREDOC
        mutation {
          updateProfile(
            firstname: "#{firstname}"
          ) {
            firstname
            user {
              email
            }
          }
        }
      HEREDOC
    end

    it "returns status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the anticipated body" do
      expect(
        parsed_response_body.dig(:data, :updateProfile, :firstname)
      ).to eq(firstname)
    end

    it "updates the logged in users' profile" do
      expect(
        parsed_response_body.dig(:data, :updateProfile, :user, :email)
      ).to eq(current_user.email)
    end
  end
end
