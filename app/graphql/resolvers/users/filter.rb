# frozen_string_literal: true

module Resolvers
  module Users
    class Filter < Resolvers::FilterBase
      def define
        GraphQL::InputObjectType.define do
          name "UserFilter"

          argument :email, types.String
        end
      end
    end
  end
end
