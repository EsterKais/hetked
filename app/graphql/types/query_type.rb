# frozen_string_literal: true

Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :users, !types[Types::UserType] do
    resolve ->(_obj, _args, _ctx) { User.all }
  end
end
