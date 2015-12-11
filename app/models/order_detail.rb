class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  before_save :set_unit_price
  after_save :update_price_orders

  def set_unit_price
    self.unit_price = book.price
  end

  def total_price
    unit_price * quantity
  end


  def update_price_orders
    order.set_total_price
    order.save
  end
end
