class Api::V1::MilestonesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :find_milestone, only: [:update, :destroy]

  swagger_controller :milestones, 'Milestones'

  swagger_api :create do
    summary 'Create a milestone.'
    param :form, 'milestone[name]', :string, :required, 'Name'
    param :form, 'milestone[due_date]', :integer, :required, 'Due Date'
    param :form, 'milestone[cost]', :integer, :optional, 'Cost'
    param :form, 'milestone[data_started]', :datetime, :optional, 'Data Started'
    param :form, 'milestone[percent_complete]', :decimal, :optional, 'Percent Complete'
    param :form, 'milestone[organization_id]', :integer, :required, 'Organization ID'
    response :bad_request
    response :una
  end

  def index
    render json: { milestones: current_user.organizations.first.milestones }, status: 200
  end

  def create
    @milestone = Milestone.new(milestone_params)
    if @milestone.save
      render json: { milestone: @milestone }, status: 201
    else
      render json: {  errors: @milestone.errors }, status: 422
    end
  end

  def update
    if @milestone.update(milestone_params)
      render json: { milestone: @milestone }, status: 200
    else
      render json:{ errors: @milestone.errors }, status: 422
    end
  end

  def destroy
    @milestone.destroy

    render json: {}, status: 200
  end

  private

  def find_milestone
    @milestone = Milestone.find(params[:id])
  end

  def milestone_params
    params.require(:milestone).permit(:name, :percent_complete, :data_started, :due_date, :cost, :organization_id)
  end
end
