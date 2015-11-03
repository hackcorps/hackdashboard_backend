class  OrganizationsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index

    @organizations = Organization.all
    render json: { organizations: @organizations }, status: 200
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: {}, status: 200
    else
      render json: { errors: @organization.errors.full_messages }, status: 422
    end
  end

  def show
    @organization = Organization.find(params[:id])
    render json:  { organization: @organization }, status: 200
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy!

    render json:  { organization: @organization }, status: 204
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
