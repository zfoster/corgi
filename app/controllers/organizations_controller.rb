class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]
  autocomplete :organization, :name, full: true

  def show

  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.create(organization_params)
    redirect_to organization_path(@organization)
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :avatar)
  end
end
