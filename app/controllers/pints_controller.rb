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
    @order = @current_user.place_order_for(User.last)
    setup_response = gateway.setup_purchase(@order.total,
      :ip => request.remote_ip,
      :return_url => confirm_url,
      :cancel_return_url => 'http://pint.me/'
    )
    @order.update_attribute('paypal_token',setup_response.token)
    redirect_to gateway.redirect_url_for(setup_response.token)
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

  private
  def gateway
    @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
      :login => "timmyd_1255717328_biz_api1.gmail.com",
      :password => "1255717341",
      :signature => "AXouHPAo4cTc9oPM33zjd5pjCDdnAqsfqnlgJf0A4pdNKTp99idxdK7A"
    )
  end

  def redeem
    
  end
end
