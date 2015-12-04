class OrdersController < ApplicationController
  def create
    if current_user.present?
    else
      redirect_to new_user_session_path
    end
  end
end
