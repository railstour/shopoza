class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_shopping_cart
  before_action :ensure_checkoutable, except: [:vt_payment_callbacks]
  before_action :define_base_url

  VeritransResult = Struct.new :redirect_url, :status_message, :status_code
  STAGING = :staging
  PRODUCTION = :production
  ACCOUNT_TYPE = STAGING # or production
  USE_VT_WEB = false # false

  def create
    if @order.present?
      USE_VT_WEB ? checkout_web : redirect_to(direct_checkouts_path)
    else
      redirect_to root_path, notice: "Nothing to checkout"
    end
  end

  def index
  end

  def delete
  end

  # fill in form for check out, in-site, using VT-Direct
  def direct_form
  end

  def vt_payment_callbacks
    checkout_id = params[:order_id]
    status_code = params[:status_code]
    transaction_status = params[:transaction_status]
    order = Order.for_user(current_user).where(checkout_id: checkout_id).first

    if order && status_code.to_s == "200" &&
      transaction_status.to_s.downcase == "capture"
      order.update_attributes(status: Order::STATUS_PAYMENT_RECEIVED)
      redirect_to root_path,
        notice: "Your payment have been received. We will process it shortly"
    else
      redirect_to root_path, alert: "Sorry, could not process the payment"
    end
  end

  def checkout_direct
    charging_params = params.merge(@order.transaction_details)
    @result = charge(charging_params)

    status_code = @result.status_code.to_s

    if status_code == '200' # successful transaction
      @order.update_attributes(status: Order::STATUS_PAYMENT_RECEIVED)
      flash[:notice] = "Your payment have been received. We will process it shortly"
      render json: {success: 1}
    elsif status_code == '202' # rejected by FDS/bank
      render json: {success: 0}
    elsif status_code == '201' # need manual confirmation at MAP
      @order.update_attributes(status: Order::STATUS_WAITING_PAYMENT)
      render json: {success: 1}
    else
      fail "Error: #{@result.status_message}"
    end
  rescue => e
    puts e.message
    render json: {success: 0}
  end

  private

  def find_shopping_cart
    @order = Order.for_user(current_user).status_shopping.first
  end

  def ensure_checkoutable
    redirect_to root_path, 
      alert: "Nothing to checkout" if @order.nil?
  end

  def define_base_url
    @base_url = if ACCOUNT_TYPE == STAGING 
      "https://api.sandbox.veritrans.co.id/v2"
    elsif ACCOUNT_TYPE == PRODUCTION
      "https://api.veritrans.co.id/v2"
    else
      fail "Base url is undefined for unknown environment"
    end
  end

  def charge(charging_params)
    server_key = ACCOUNT_TYPE == :staging ? 
      ENV["VT_DEV_SERVER_KEY"] : ENV["VT_PROD_SERVER_KEY"] 

    vt_result = VeritransResult.new

    RestClient::Request.execute(
      method: :post,
      url: "#{@base_url}/charge",
      timeout: 40,
      open_timeout: 40,
      headers: {
        "Authorization" => "Basic #{Base64.strict_encode64(server_key)}",
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "User-Agent" => "Bukuniku"
      },
      payload: JSON.generate(charging_params)
    ) do |response, request, result|
      result = JSON.parse(response).try(:with_indifferent_access)

      vt_result.redirect_url = result[:redirect_url]
      vt_result.status_message = result[:status_message]
      vt_result.status_code = result[:status_code]
    end

    vt_result
  end

  def checkout_web
    charging_params = {
      payment_type: 'VTWEB'
    }.merge(@order.transaction_details)

    # @result = Veritrans.charge(charging_params)
    @result = charge(charging_params)

    if @result.redirect_url
      @order.update_attributes(status: Order::STATUS_WAITING_PAYMENT)
      redirect_to @result.redirect_url
      return
    else
      redirect_to root_path, alert: @result.status_message
    end
  end
end
