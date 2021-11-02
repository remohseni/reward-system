class RewardsController < ApplicationController
  def import
    result = RewardSystem::CalculationService.call(import_file)
    render json: result, status: :ok
  end

  private

  def import_file
    params[:file]
  end
end
