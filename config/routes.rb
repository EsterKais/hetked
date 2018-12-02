# frozen_string_literal: true

Rails.application.routes.draw do
  root controller: :status, action: :show
  get :status, controller: :status, action: :show
end
