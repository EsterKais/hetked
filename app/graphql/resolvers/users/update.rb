# frozen_string_literal: true

module Resolvers
  module Users
    class Update < GraphQL::Function
      argument :email, !types.String

      type Types::UserType

      def call(_obj, args, _ctx)
        user = User.find(args[:id])
        user.update(email: args[:email])
      end
    end
  end
end
