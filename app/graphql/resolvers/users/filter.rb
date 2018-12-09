# frozen_string_literal: true

module Resolvers
  module Users
    class Filter
      def define
        GraphQL::InputObjectType.define do
          name "UserFilter"

          argument :email, types.String
        end
      end

      def apply(scope, value)
        result = []

        result << email_search(scope, value["email"]) if value["email"]

        result.flatten
      end

      private

      def email_search(scope, email)
        scope.where("email LIKE ?", "%#{email}%")
      end
    end
  end
end
