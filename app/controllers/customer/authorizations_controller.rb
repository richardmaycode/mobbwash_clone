module Customer
  class AuthorizationsController < ApplicationController
    layout "customer"

    before_action :set_request, only: [ :new,  :create ]
    def new
      @request = Request.find(params[:request_id])
      @payment_methods = Current.user.payment_processor.payment_methods.order(default: :desc)
    end

    def create
      @request = Request.find(params[:request_id])
      @payment_method = Pay::PaymentMethod.find(params[:payment_method_id])
      Current.user.payment_processor.payment_method_token = @payment_method.processor_id
      Current.user.payment_processor.charge(@request.price.amount, capture_method: "manual")
      @request.update(status: "unassigned", capture_id: Current.user.charges.last.payment_intent_id)

      redirect_to customer_request_path(@request), notice: "Payment Authorized"
    rescue Pay::Error => e
      flash[:alert] = e.message
      render :new, status: :unprocessable_entity
    end

    private

    def set_request
      @request = Request.find(params[:request_id])
    end

    def set_checkout_session
      payment_processor = Current.user.set_payment_processor(:stripe)

      args = {
        mode: :setup,
        ui_mode: :embedded,
        currency: "usd",
        metadata: { request_id: @request.id },
        return_url: customer_auths_url
      }

      @checkout_session = payment_processor.checkout(**args)
    end
  end
end
