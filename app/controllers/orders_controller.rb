class OrdersController < ApplicationController
  def index
    @orders = Order.for_user(current_user)
  end

  def show
    @order = Order.find(params[:id])
  end

  def no_cart
    flash[:alert] = 'you have not put anything in the cart'
    redirect_to root_path
  end

  def create
    if current_user.present?
      order = find_order
      if order.blank?
        flash[:alert] = "This Order is not belongs to you"
        redirect_to :back
        return
      end

      quantity = params[:order_detail][:quantity]
      if !!(quantity =~ /^\d+$/) && quantity.to_i < 1
        flash[:alert] = 'quantity must be number and greater than 0'
        redirect_to :back
        return
      end

      book = Book.find(params[:order_detail][:book_id])

      order_detail = OrderDetail.find_by(book: book, order: order)
      success = false
      if order_detail.present?
        order_detail.quantity += params[:order_detail][:quantity].to_i
        success = order_detail.save
      else
        order_detail = OrderDetail.create(
          book: book,
          quantity: params[:order_detail][:quantity],
          order: order
        )
        success = order_detail.persisted?
      end

      if success
        flash[:notice] = 'order added successfully'
      else
        flash[:alert] = order_detail.errors.full_messages.to_sentence
      end
      redirect_to :back
    else
      redirect_to new_user_session_path
    end
  end


  private
  def find_order
    order = Order.find_by_status('shopping')

    if order.blank?
      order = Order.new(user: current_user, status: 'shopping')
      order = nil unless order.save
    end
    order
  end
end
