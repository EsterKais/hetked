# frozen_string_literal: true

module Resolvers
  module Profiles
    class Update < GraphQL::Function
      argument :firstname, types.String
      argument :lastname, types.String
      argument :username, types.String

      type Types::ProfileType

      def call(_obj, args, ctx)
        profile = User.find(ctx[:current_user].id).profile
        profile.update(
          firstname: args[:firstname],
          lastname: args[:lastname],
          username: args[:username]
        )

        profile
      end
    end
  end
end
