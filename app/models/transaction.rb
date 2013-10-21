class Transaction < ActiveRecord::Base
  belongs_to :payment

  def response=(response)
    self.success       = response.success?
    self.authorization = response.authorization
    self.message       = response.message
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success       = false
    self.message       = e.message
  end
end
