# frozen_string_literal: true

class StatusController < ApplicationController
  def show
    render json: { status: :ok }
  end
end
