class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cart

  def set_cart
    if current_user.present?
      @cart = Order.status_shopping.for_user(current_user).first
    end
  end
end
