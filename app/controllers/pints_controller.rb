class PintsController < ApplicationController
  before_filter :require_login
  def index
    @pints = Pint.all
  end

  def buy
    @recipient = User.create_from_screen_name(params[:screen_name])
    @pint = @recipient.pints.new
  end

  def create
    recipient = User.find(params[:pint][:user_id])
    @order = @current_user.place_order_for(recipient)
    setup_response = gateway.setup_purchase(@order.total,
      :ip => request.remote_ip,
      :return_url => confirm_url,
      :cancel_return_url => 'http://pint.me/'
    )
    @order.update_attribute('paypal_token',setup_response.token)
    if @order.total > 0
      redirect_to gateway.redirect_url_for(setup_response.token)
    else
      @order.send_pints
      render :action => 'confirm'
      return
    end
  end

  def confirm
    @details = gateway.details_for(params[:token])
    @order = Order.find_by_paypal_token(params[:token])
    if @order
      purchase = gateway.purchase(@order.total,
        :ip => request.remote_ip,
        :payer_id => @details.params['payer_id'],
        :token => params[:token]
      )
      # if @order.total == 0, then we just give the beer credit
      if !purchase.success?
        @message = purchase.message
        render :action => 'error'
        return
      else
        @order.send_pints
      end
    else
      @message = 'We could not find your order.'
      render :action => 'error'
      return
    end
  end

  def redeem
    unless current_user.pints.available.count > 0
      flash[:error] = "You have no pints"
      redirect_to root_url
    end
  end

  def confirm_redeem
    business_secret = params[:secret_input]
    if current_user.pints.available.count > 0
      @business = Business.find_by_secret_code(business_secret)
      if @business
        pint =current_user.pints.available.first
        pint.business = @business
        pint.redemption_date = Date.today
        pint.save
        render :action => "enjoy"
      else
        flash[:error] = "Invalid Code"
        redirect_to redeem_url
      end
    else
      flash[:error] = "You have no pints"
      redirect_to root_url
    end
  end

  private
  def gateway
    @config ||= PaymentGateway.instance.configs[Rails.env]
    @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
      :login => @config['login'],
      :password => @config['password'],
      :signature => @config['signature']
    )
  end

end
