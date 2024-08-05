module Customer
  class PaymentsController < ApplicationController
    layout "customer"
    before_action :set_user
    def new
      @request = Request.includes(:price, :vendor, :bids).find(params[:request_id])
    end

    def create
      @request = Request.includes(:price, :vendor, :bids).find(params[:request_id])
      tip_amount = params[:tip_amount].to_f
      puts (tip_amount * 100).to_i
      puts (tip_amount * 100).to_i + @request.price.amount
      render :new
      Stripe.api_key = Rails.application.credentials.dig(:development, :stripe, :private_key)
      intent = Stripe::PaymentIntent.capture(
        @request.capture_id,
        {
          amount_to_capture: @request.price.amount
        }
      )

      puts intent
    end

    private

    def set_user
      @user ||= Current.user
    end

    def set_checkout_session
      payment_processor = Current.user.set_payment_processor(:stripe)

      args = {
        allow_promotion_codes: false,
        # automatic_tax: { enabled: true }, # TODO: Need to enable Stripe Tax to use this feature
        # consent_collection: { terms_of_service: :required }, # TODO: Setup TOC page to display (add url in stripe dashboard)
        customer_update: { address: :auto },
        mode: :payment,
        ui_mode: :embedded,
        line_items: [
          price_data:  {
            unit_amount:  @request.price.amount,
            product: "prod_QZoMj98uGzCuFf",
            currency: :usd
          }, quantity: 1
        ],
        metadata: { request_id: @request.id },
        return_url: customer_fulfillments_url
      }

      @checkout_session = payment_processor.checkout(**args)
    end
  end
end
