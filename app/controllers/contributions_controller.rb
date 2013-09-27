class ContributionsController < ApplicationController
  def create
    @contribution = Contribution.create(contribution_params)
    redirect_to support_content_index_path, notice: 'Thank you for contributing. Someone will be in touch with you shortly.'
  end

  private

  def contribution_params
    params.require(:contribution).permit(:note, :email)
  end
end