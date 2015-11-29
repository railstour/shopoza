module ApplicationHelper
  def money_amount(amount)
    number_to_currency(amount, unit: 'Rp.')
  end
end
