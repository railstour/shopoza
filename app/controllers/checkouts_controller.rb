class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_shopping_cart

  USE_VT_WEB = true

  def create
    if @order.present?
      USE_VT_WEB ? checkout_web : checkout_direct
    else
      redirect_to root_path, notice: "Nothing to checkout"
    end
  end

  def index
  end

  def delete
  end

  private

  def find_shopping_cart
    @order = Order.for_user(current_user).status_shopping
  end

  def checkout_web
  end

  def checkout_direct
  end
end
