# frozen_string_literal: true

Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :users, function: Resolvers::Users::Search
  field :profiles, function: Resolvers::Profiles::Search
end
