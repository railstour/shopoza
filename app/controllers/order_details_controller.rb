class OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.joins(:order).find_by(id: params[:id], orders: { user_id: current_user.id })
    if order_detail.present?
      order_detail.update_attributes(order_detail_params)
    end
    redirect_to :back
  end

  def destroy
    order_detail = OrderDetail.joins(:order).find_by(id: params[:id], orders: { user_id: current_user.id })
    if order_detail.present?
      order_detail.destroy
    end
    redirect_to order_path(params[:order_id])
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:quantity)
  end
end
