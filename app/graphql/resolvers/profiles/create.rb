# frozen_string_literal: true

module Resolvers
  module Profiles
    class Create < GraphQL::Function
      argument :firstname, types.String
      argument :lastname, types.String
      argument :username, types.String

      type Types::ProfileType

      def call(_obj, args, ctx)
        user = User.find(ctx[:current_user].id)

        user.create_profile(
          firstname: args[:firstname],
          lastname: args[:lastname],
          username: args[:username]
        )
      end
    end
  end
end
