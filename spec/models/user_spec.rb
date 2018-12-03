# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it_behaves_like "ApplicationRecord", :user

  it { is_expected.to(validate_presence_of(:email)) }
  it { is_expected.to(have_one(:profile)) }

  context "when destroying user" do
    let(:user) { create(:user, :with_profile) }

    it "also destroys the associated profile" do
      user.destroy
      expect(Profile.all).to eq([])
    end
  end
end
