# frozen_string_literal: true

module Resolvers
  module Profiles
    class Filter
      FILTERABLE_ATTRIBUTES = %w[firstname lastname username].freeze

      def define
        GraphQL::InputObjectType.define do
          name "ProfileFilter"

          argument :firstname, types.String
          argument :lastname, types.String
          argument :username, types.String
        end
      end

      def apply(scope, value)
        result = []

        FILTERABLE_ATTRIBUTES.each do |attr|
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
end
