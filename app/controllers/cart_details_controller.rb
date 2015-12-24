class CartDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.joins(:order).find_by(id: params[:id], orders: { user_id: current_user.id, status: 'shopping' })
    if order_detail.present?
      if order_detail.update_attributes(order_detail_params)
        flash[:notice] = "Order is updated successfully"
      else
        flash[:alert] = order_detail.errors.full_messages.to_sentence
      end
    end
    redirect_to :back
  end

  def destroy
    order_detail = OrderDetail.joins(:order).find_by(id: params[:id], orders: { user_id: current_user.id, status: 'shopping' })
    if order_detail.present?
      if order_detail.destroy
        flash[:notice] = "order is deleted successfully"
      else
        flash[:alert] = order_detail.errors.full_messages.to_sentence
      end
    end
    redirect_to order_path(params[:order_id])
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:quantity)
  end
end
