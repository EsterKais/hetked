# frozen_string_literal: true

module Resolvers
  module Users
    class Update < GraphQL::Function
      argument :email, !types.String

      type Types::UserType

      def call(_obj, args, ctx)
        user = User.find(ctx[:current_user].id)
        user.update(email: args[:email])

        user
      end
    end
  end
end
