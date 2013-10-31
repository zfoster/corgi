class PaymentsController < ApplicationController

  def new
    @registration = Registration.find(params[:registration_id])
    @payment = Payment.new(registration: @registration, amount_in_cents: @registration.event.price)
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.ip_address = request.remote_ip
    update_user_billing
    if @payment.save
      if @payment.purchase
        redirect_to event_path(@payment.registration.event), notice: 'Your payment was successful'
      else
        @payment.registration.destroy
        redirect_to event_path(@payment.registration.event), notice: "There was a billing error!"
      end
    else
      @payment.registration.destroy
      redirect_to event_path(@payment.registration.event), notice: "There was a billing error!"
    end
  end


  private

  def payment_params
    params.require(:payment).permit(:amount_in_cents, :cardholder_name, :card_type, :card_expires_on, :card_number, :card_verification, :registration_id, user_attributes: [:address_line_1, :address_line_2, :city, :state, :zip_code])
  end

  def update_user_billing
    @payment.registration_user.update_attributes(payment_params[:user])
  end
end