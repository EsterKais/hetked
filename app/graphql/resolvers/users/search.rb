# frozen_string_literal: true

module Resolvers
  module Users
    class Search < Resolvers::SearchBase
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
