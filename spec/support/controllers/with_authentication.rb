# frozen_string_literal: true

require "jwt"

RSpec.shared_context "with authentication" do
  let(:user) { create(:user) }
  let(:payload) { { email: user.email } }
  let(:jwt_token) { JWT.encode(payload, nil, "none") }
  let(:headers) { { authentication: jwt_token } }

  before { request.headers.merge! headers }
end
