# frozen_string_literal: true

require "jwt"

RSpec.shared_context "with authentication" do
  let(:current_user) { create(:user) }
  let(:payload) { { id: current_user.id } }
  let(:jwt_token) { JWT.encode(payload, nil, "none") }
  let(:headers) { { authentication: jwt_token } }
end
