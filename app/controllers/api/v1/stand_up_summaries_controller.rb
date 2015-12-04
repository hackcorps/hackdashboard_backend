class Api::V1::StandUpSummariesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :get_organization_from_current_user, only: [:create]

  swagger_controller :stand_up_summaries, 'StandUpSummaries'

  swagger_api :create do
    summary 'Create a stand-up summary.'
    param :form, 'stand_up_summary[text]', :string, :required, 'Update Text'
    param :form, 'stand_up_summary[noted_date]', :date, :required, 'Noted at'
    response :unauthorized
  end

  def create
    @stand_up_summary = @organization.stand_up_summaries.new(stand_up_summary_params)

    if @stand_up_summary.save
      render json: { stand_up_summary: @stand_up_summary }, status: 201
    else
      render json: { errors: @stand_up_summary.errors }, status: 422
    end
  end

  def update
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
