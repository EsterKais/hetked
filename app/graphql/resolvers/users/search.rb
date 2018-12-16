# frozen_string_literal: true

require "search_object/plugin/graphql"

module Resolvers
  module Users
    class Search
      include SearchObject.module(:graphql)

      FILTERABLE_ATTRIBUTES = %w[email].freeze

      scope { User.all }

      type !types[Types::UserType]

      option(
        :filter,
        type: Resolvers::Users::Filter.new.define,
        with: :apply_filter
      )

      private

      def apply_filter(scope, value)
        Resolvers::Users::Filter.new.apply(
          scope,
          value,
          FILTERABLE_ATTRIBUTES
        )
      end
    end
  end
end
