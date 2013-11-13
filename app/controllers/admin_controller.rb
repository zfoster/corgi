class AdminController < ApplicationController
  before_filter :authorize_user!
  before_filter :authorize_admin!
  layout 'admin'

  def index
  end
end
