# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_save :generate_uuid
  before_save :normalize_blank_values

  UUID_REGEX = \
    /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/.freeze

  def generate_uuid
    self.id ||= SecureRandom.uuid
  end

  def normalize_blank_values
    attributes.each { |column, _| self[column] = self[column].presence }
  end
end
