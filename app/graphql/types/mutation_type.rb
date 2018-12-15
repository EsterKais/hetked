# frozen_string_literal: true

Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, function: Resolvers::Users::Create.new
  field :updateUser, function: Resolvers::Users::Update.new
end
