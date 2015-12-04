class HomeController < ApplicationController
  def index
    @books = Book.limit(10)
    @order_detail = OrderDetail.new
  end
end
