# frozen_string_literal: true

require "search_object/plugin/graphql"

module Resolvers
  class SearchBase
    include SearchObject.module(:graphql)
  end
end
