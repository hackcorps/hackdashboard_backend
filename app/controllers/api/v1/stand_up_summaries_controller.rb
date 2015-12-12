class Api::V1::StandUpSummariesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :get_organization_from_current_user

  swagger_controller :stand_up_summaries, 'StandUpSummaries'

  swagger_api :create do
    summary 'Create a stand-up summary .'
    param :form, 'stand_up_summary[text]', :string, :required, 'Update Text'
    param :form, 'stand_up_summary[noted_date]', :date, :required, 'Noted at'
    response :unauthorized
  end

  swagger_api :index do
    summary 'Return all stand-ups summaries of user\'s organization .'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an existing stand-up summary'
    param :path, :id, :integer, :required, "Stand-up summary ID"
    param :form, 'stand_up_summary[text]', :string, :optional, 'Text'
    response :not_found
  end

  swagger_api :destroy do
    summary "Deletes an existing stand-up summary"
    param :path, :id, :integer, :required, "Stand-up summary ID"
    response :unauthorized
    response :not_found
  end

  swagger_model :StandUpSummary do
    description "A Stand-up Summary object."
    property :id, :integer, :required, "Stand-up summary ID"
    property :text, :string, :required, "Text"
    property :noted_date, :date, :required, "Noted date"
    property :organization_id, :integer, :required, "Organization ID"
  end



  def index
    start_time = Time.zone.now.beginning_of_week
    render json: @organization.stand_up_summaries.where('noted_date between ? and ?', start_time, start_time + 6.days), status: 200
    end

  def create
    @stand_up_summary = @organization.stand_up_summaries.new(stand_up_summary_params)

    if @stand_up_summary.save
      render json: @stand_up_summary, status: 201
    else
      render json: { errors: @stand_up_summary.errors }, status: 422
    end
  end

  def update
    @stand_up_summary = @organization.stand_up_summaries.find(params[:id])

    if @stand_up_summary.update(text: stand_up_summary_params[:text])
      render json: @stand_up_summary, status: 200
    else
      render json: { errors: @stand_up_summary.errors }
    end
  end

  def destroy
    @organization.stand_up_summaries.find(params[:id]).destroy

    render json: {}, status: 200
  end

  private

  def get_organization_from_current_user
    raise ActiveRecord::RecordNotFound if @current_user.organizations.count < 0
    @organization = @current_user.organizations.first
  end

  def stand_up_summary_params
    params.require(:stand_up_summary).permit( :text, :noted_date, :organization_id)
  end
end
