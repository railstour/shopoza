class OrdersController < ApplicationController
  def index
    @orders = Order.for_user(current_user).where.not(status: 'shopping')
  end

  def show
    @order = Order.for_user.where.not(status: 'shopping').find(params[:id])
  end
end
