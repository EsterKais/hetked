# frozen_string_literal: true

module Resolvers
  module Profiles
    class Filter < Resolvers::FilterBase
      def define
        GraphQL::InputObjectType.define do
          name "ProfileFilter"

          argument :firstname, types.String
          argument :lastname, types.String
          argument :username, types.String
        end
      end
    end
  end
end
