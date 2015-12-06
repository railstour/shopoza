class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  before_save :set_unit_price

  def set_unit_price
    self.unit_price = book.price
  end
end
