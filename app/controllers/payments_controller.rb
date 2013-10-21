class PaymentsController < ApplicationController

  def new
    @registration = Registration.find(params[:registration_id])
    @payment = Payment.new(registration: @registration, amount_in_cents: @registration.event.price)
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.ip_address = request.remote_ip
    if @payment.save
      if @payment.purchase
        redirect_to event_path(@payment.registration.event), notice: 'Your payment was successful'
      else
        redirect_to event_path(@payment.registration.event), error: "#{@payment.errors.full_messages}"
      end
    else
      redirect_to event_path(@payment.registration.event), error: "#{@payment.errors.full_messages}"
    end
  end


  private

  def payment_params
    params.require(:payment).permit(:amount_in_cents, :first_name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification, :registration_id)
  end
end