class Payment < ActiveRecord::Base
  has_many :transactions
  belongs_to :registration

  delegate :user, to: :registration, prefix: true
  after_create :validate_card

  attr_accessor :card_number, :card_verification

  def purchase
    response = GATEWAY.purchase(amount_in_cents, credit_card, billing_address)
    response.success?
  end

  def price_in_cents
    (registration.price*100).round
  end

  private

  def billing_address
    {
      :ip => ip_address,
      :billing_address => {
        :name     => registration_user.display_name,
        :address1 => address_line_1,
        :address2 => address_line_2,
        :city     => city,
        :state    => state,
        :zip      => zip_code
      }
    }
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.full_messages
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end

end
