class Api::V1::StandUpsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :find_stand_up, only: [:update, :destroy]

  swagger_controller :stand_ups, 'StandUps'

  swagger_api :create do
    summary 'Create a stand-up.'
    param :form, 'stand_up[update_text]', :string, :required, 'Update Text'
    param :form, 'stand_up[noted_at]', :date, :required, 'Noted at'
    param :form, 'stand_up[milestone_id]', :integer, :required, 'Milestone ID'
    response :unauthorized
  end

  swagger_api :index do
    summary 'Return all stand-ups of current user.'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an existing stand-up'
    param :path, :id, :integer, :required, "Stand-up ID"
    param :form, 'stand_up[update_text]', :string, :optional, 'Update Text'
    param :form, 'stand_up[noted_at]', :date, :optional, 'Noted at'
    param :form, 'stand_up[milestone_id]', :integer, :optional, 'Milestone ID'
    response :unauthorized
    response :not_found
  end

  swagger_api :destroy do
    summary "Deletes an existing stand-up"
    param :path, :id, :integer, :required, "Stand-up Id"
    response :unauthorized
    response :not_found
  end

  swagger_model :StandUp do
    description "A Stand-up object."
    property :id, :integer, :required, "Stand-up ID"
    property :noted_at, :date, :required, "Noted at"
    property :milestone_id, :integer, :required, "Milestone ID"
    property :user_id, :integer, :required, "User ID"
    property :stand_up_summary_id, :integer, :optional, "Stand-up Summary ID"
  end

  def index
    render json: { stand_ups: StandUp.where( 'noted_at = ?', Date.today) }, status: 200
  end

  def create

    @stand_up = @current_user.stand_ups.new(stand_up_params)

    if @stand_up.save
      render json: { stand_up: @stand_up }, status: 201
    else
      render json: { errors: @stand_up.errors }, status: 422
    end
  end

  def update

   if  @stand_up.update( stand_up_params)
     render json: { stand_up: @stand_up }, status: 200
   else
     render json: { errors: @stand_up.errors }
   end
  end


  def destroy
    @stand_up.destroy

    render json: {}, status: 200
  end

  private

  def find_stand_up
    @stand_up  = StandUp.find(params[:id])
  end
  def stand_up_params
    params.require(:stand_up).permit( :update_text, :noted_at, :user_id, :stand_up_summary_id, :milestone_id)
  end
end
