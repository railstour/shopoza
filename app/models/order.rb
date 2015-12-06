class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_details

  validates_inclusion_of :status, in: ['shopping']

  scope :for_user, lambda{ |user| where(user: user) }
end
