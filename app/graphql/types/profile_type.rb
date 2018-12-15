# frozen_string_literal: true

Types::ProfileType = GraphQL::ObjectType.define do
  name "Profile"

  field :id, !types.ID
  field :firstname, !types.String
  field :lastname, !types.String
  field :username, !types.String
  # field :birthday, !types.ISO8601DateTime
  field :user, -> { Types::UserType }
end
