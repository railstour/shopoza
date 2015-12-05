class Book < ActiveRecord::Base
  has_many :order_details
  validates_presence_of :title
end
