# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :model do
  it_behaves_like "ApplicationRecord", :profile

  it { is_expected.to(validate_presence_of(:username)) }
  it { is_expected.to(belong_to(:user)) }
end
