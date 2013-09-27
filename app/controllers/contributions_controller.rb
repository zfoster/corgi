class ContributionsController < ApplicationController
  def create
    @contribution = Contribution.new
    @contribution.update_attributes(note: params[:contribution][:note], email: params[:contribution][:email])
    redirect_to support_content_index_path, notice: 'Thank you for contributing. Someone will be in touch with you shortly.'
  end
end