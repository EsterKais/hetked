# frozen_string_literal: true

module Resolvers
  module Users
    class Create < GraphQL::Function
      argument :email, !types.String

      type Types::UserType

      def call(_obj, args, _ctx)
        User.create!(
          email: args[:email]
        )
      end
    end
  end
end
