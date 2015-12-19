class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_details, dependent: :destroy

  STATUS_SHOPPING = 'shopping'
  STATUS_CANCELLED = 'cancelled'
  STATUS_WAITING_PAYMENT = 'waiting_payment'
  STATUS_PAYMENT_RECEIVED = 'payment_received'
  STATUS_PROCESSED = 'processed'
  STATUS_DELIVERING = 'shipping'
  STATUS_RECEIVED = 'received'

  ALL_STATUS = [
    STATUS_SHOPPING,
    STATUS_CANCELLED,
    STATUS_WAITING_PAYMENT,
    STATUS_PAYMENT_RECEIVED,
    STATUS_PROCESSED,
    STATUS_DELIVERING,
    STATUS_RECEIVED
  ]

  validates_inclusion_of :status, in: ALL_STATUS

  scope :for_user, lambda{ |user| where(user: user) }
  scope :status_shopping, lambda{ where(status: STATUS_SHOPPING)}

  before_save :set_total_price

  def set_total_price
    self.total_price = order_details.sum('unit_price * quantity')
  end

  def transaction_details
    {
      transaction_details: {
        order_id: id,
        gross_amount: total_price
      },
      item_details: [].tap do |item_details|
        order_details.each do |item_detail|
          book = item_detail.book
          item_details << {
            id: book.id,
            price: book.price,
            quantity: item_detail.quantity,
            name: book.title
          }
        end
      end
    }
  end
end
