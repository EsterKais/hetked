# frozen_string_literal: true

require "search_object/plugin/graphql"

module Resolvers
  module Users
    class Search
      include SearchObject.module(:graphql)

      scope { User.all }

      type !types[Types::UserType]

      option(
        :filter,
        type: Resolvers::Users::Filter.new.define,
        with: :apply_filter
      )

      private

      def apply_filter(scope, value)
        Resolvers::Users::Filter.new.apply(scope, value)
      end
    end
  end
end
