# frozen_string_literal: true

module Resolvers
  class FilterBase
    def apply(scope, value, filterable_attributes)
      result = []

      filterable_attributes.each do |attr|
        result << includes_search(scope, attr, value[attr]) if value[attr]
      end

      result.flatten
    end

    private

    def includes_search(scope, attr, value)
      scope.where("#{attr} LIKE ?", "%#{value}%")
    end
  end
end
