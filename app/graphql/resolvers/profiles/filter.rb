# frozen_string_literal: true

module Resolvers
  module Profiles
    class Filter
      def define
        GraphQL::InputObjectType.define do
          name "ProfileFilter"

          argument :firstname, types.String
        end
      end

      def apply(scope, value)
        result = []

        if value["firstname"]
          result << firstname_search(scope, value["firstname"])
        end

        result.flatten
      end

      private

      def firstname_search(scope, firstname)
        scope.where("firstname LIKE ?", "%#{firstname}%")
      end
    end
  end
end
