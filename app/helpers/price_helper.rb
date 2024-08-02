module PriceHelper
  def formatted_amount(amount)
    number_to_currency(amount * 0.01)
  end
end
