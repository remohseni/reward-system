class RewardsController < ApplicationController
  def import
    render json: {status: :ok}, status: :ok
  end
end
