class OrdersController < ApplicationController
  def create
    if current_user.present?
      order = find_order
      if order.blank?
        redirect_to :back
        return
      end

      book = Book.find(params[:order_detail][:book_id])

      order_detail = OrderDetail.find_by(book: book, order: order)
      if order_detail.present?
        order_detail.quantity += params[:order_detail][:quantity].to_i
        order_detail.save
      else
        OrderDetail.create(book: book, quantity: params[:order_detail][:quantity], order: order)
      end
      redirect_to :back
    else
      redirect_to new_user_session_path
    end
  end


  private
  def find_order
    order = Order.find_by_status('template')

    if order.blank?
      order = Order.new(user: current_user, status: 'template')
      order = nil unless order.save
    end
    order
  end
end
