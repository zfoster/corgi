class ContentController < ApplicationController

  def support
    render layout: 'application'
    @page_title = "MADi | Support and Contribute"
  end

end
