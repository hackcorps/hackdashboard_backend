class Api::V1::MilestonesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_organization_current_user, only: [:create]
  before_action :find_milestone, only: [:update, :destroy]
  respond_to :json

  swagger_controller :milestones, 'Milestones'

  swagger_api :create do
    summary 'Create a milestone.'
    param :form, 'milestone[name]', :string, :required, 'Name'
    param :form, 'milestone[due_date]', :integer, :required, 'Due Date'
    param :form, 'milestone[cost]', :integer, :optional, 'Cost'
    param :form, 'milestone[data_started]', :datetime, :optional, 'Data Started'
    param :form, 'milestone[percent_complete]', :decimal, :optional, 'Percent Complete'
    response :unauthorized
  end

  swagger_api :index do
    summary 'Return all milestone of organization.'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an existing milestone'
    param :path, :id, :integer, :required, "Milestone Id"
    param :form, 'milestone[name]', :string, :optional, 'Name'
    param :form, 'milestone[due_date]', :date, :optional, 'Due Date'
    param :form, 'milestone[cost]', :integer, :optional, 'Cost'
    param :form, 'milestone[data_started]', :datetime, :optional, 'Data Started'
    param :form, 'milestone[percent_complete]', :decimal, :optional, 'Percent Complete'
    param :form, 'milestone[organization_id]', :integer, :optional, 'Organization ID'
    response :unauthorized
    response :not_found
  end

  swagger_api :destroy do
    summary "Deletes an existing milestone"
    param :path, :id, :integer, :required, "Milestone Id"
    response :unauthorized
    response :not_found
  end

  swagger_model :Milestone do
    description "A Milestone object."
    property :id, :integer, :required, "Milestone Id"
    property :name, :string, :required, "Name"
    property :due_date, :date, :required, "Due Date"
    property :cost, :integer, :optional, "Cost"
    property :percent_complete, :decimal, :optional, "Percent Complete"
    property :data_started, :datetime, :optional, "Data Started"
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
      render json:{ errors: @milestone.errors }
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

  def set_organization_current_user
   if @current_user.organizations.count > 0
    params[:milestone][:organization_id] ||= @current_user.organizations.first.id
   end
  end

  def milestone_params
    params.require(:milestone).permit(:name, :percent_complete, :data_started, :due_date, :cost, :organization_id)
  end
end
