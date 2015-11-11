class Api::V1::MilestonesController < ApplicationController

  def create
    @milestone = Milestone.new(milestone_params)
    if @milestone.save
      render json: { milestone: @milestone }, status: 201
    else
      render json: {}, status: 422
    end
  end

  def milestone_params
    params.require(:milestone).permit(:name, :percent_complete, :data_started, :due_date, :cost, :organization_id)
  end
end
