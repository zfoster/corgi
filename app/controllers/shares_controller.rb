class SharesController < ApplicationController
  before_action :set_share, only: [:show, :edit, :update, :destroy]

  def index
    @share = Share.all
  end

  def show
  end

  def new
    @share = Share.new
  end

  def edit
  end

  def create
    @share = Share.new(share_params)
    if @share.save
      redirect_to @share, notice: 'Share was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @share.update(share_params)
      redirect_to @share, notice: 'Share was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @share.destroy
    redirect_to share_path
  end

  private
    def set_share
      @share = Share.find(params[:id])
    end

    def share_params
      params.require(:share).permit(:message)
    end
end
