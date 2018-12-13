module ApplicationHelper
  def card?
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.retrieve(self.pay.customer)
    binding.pry
  end
end
