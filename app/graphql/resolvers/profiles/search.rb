# frozen_string_literal: true

module Resolvers
  module Profiles
    class Search < Resolvers::SearchBase
      FILTERABLE_ATTRIBUTES = %w[firstname lastname username].freeze

      scope { Profile.all }

      type !types[Types::ProfileType]

      option(
        :filter,
        type: Resolvers::Profiles::Filter.new.define,
        with: :apply_filter
      )

      private

      def apply_filter(scope, value)
        Resolvers::Profiles::Filter.new.apply(
          scope,
          value,
          FILTERABLE_ATTRIBUTES
        )
      end
    end
  end
end
