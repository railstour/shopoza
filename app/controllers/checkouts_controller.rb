class CheckoutsController < ApplicationController
  before_action :authenticate_user!

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
end
