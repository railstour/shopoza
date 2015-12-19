class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  USE_VT_WEB = true

  def create
  	order = Order.for_user(current_user).status_shopping
    if order.present?
      redirect_to root_path, notice: "Checked out!"
    else
      redirect_to root_path, notice: "Nothing to checkout"
    end
  end

  def index
  end

  def delete
  end

  private

  def checkout_web
  end

  def checkout_direct
  end
end
