class RegistrationsController < ApplicationController
  before_filter :set_registration, only: [:cancel_registration]

  def cancel_registration
    @registration.cancel
    redirect_to event_path(@registration.event), notice: 'Successfully removed you from this event.'
  end

  private

    def set_registration
      @registration = Registration.find(params[:id])
    end

end