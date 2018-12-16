# frozen_string_literal: true

Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, function: Resolvers::Users::Create.new
  field :updateUser, function: Resolvers::Users::Update.new

  field :createProfile, function: Resolvers::Profiles::Create.new
  field :updateProfile, function: Resolvers::Profiles::Update.new
end
