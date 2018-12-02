# frozen_string_literal: true

RSpec.shared_examples_for "ApplicationRecord" do |model_name, trait|
  let(:model) { build(model_name, trait) }

  context "when creating" do
    before { model.save }

    it "assigns a uuid" do
      expect(model.reload.id).to match(ApplicationRecord::UUID_REGEX)
    end
  end

  context "when updating" do
    subject(:saved_object) { model.save }

    let(:model) { create(model_name, trait) }

    it "does not assign a new uuid" do
      expect { saved_object }.not_to(change(model, :id))
    end
  end
end
