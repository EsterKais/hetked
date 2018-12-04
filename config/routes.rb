# frozen_string_literal: true

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  root controller: :status, action: :show
  get :status, controller: :status, action: :show
end
