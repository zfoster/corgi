class SocialObjectsController < ApplicationController
  before_action :set_social_object, only: [:show, :edit, :update, :destroy]

  def index
    @social_objects = SocialObject.all
  end

  def show
  end

  def new
    @social_object = SocialObject.new
  end

  def edit
  end

  def create
    @social_object = SocialObject.new(social_object_params)
    if @social_object.save
      redirect_to @social_object, notice: 'Social object was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @social_object.update(social_object_params)
      redirect_to @social_object, notice: 'Social object was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @social_object.destroy
    redirect_to social_objects_path
  end

  private
    def set_social_object
      @social_object = SocialObject.find(params[:id])
    end

    def social_object_params
      params.require(:social_object).permit(:corgi_foreign_key, :corgi_create_date, :type, :title, :description, :uri)
    end
end
