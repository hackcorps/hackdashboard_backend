class  OrganizationsController < ApplicationController
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
      render json: { status: true }, status: 201
    else
      render json: { status: false, errors: @organization.errors.full_messages }, status: 422
    end
  end
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy!
    render json:  {organization: @organization }, status: 204
  end
  private
  def organization_params
    params.require(:organization).permit( :name )
  end

end
