class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_details

  validates_inclusion_of :status, in: ['shopping']

  scope :for_user, lambda{ |user| where(user: user) }

  before_save :set_total_price

  def set_total_price
    self.total_price = order_details.sum('unit_price * quantity')
  end
end
