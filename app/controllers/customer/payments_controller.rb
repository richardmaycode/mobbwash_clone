module Customer
  class PaymentsController < ApplicationController
    layout "customer"
    before_action :set_user
    def new
      @request = Request.includes(:services, :vehicle, :vendor, :bids).find(params[:request_id])
      @payment = Payment.new

      set_checkout_session
    rescue Pay::Error => e
      flash[:alert] = e.message
      redirect_to customer_request_path(@request)
    end

    private

    def set_user
      @user ||= Current.user
    end

    def payment_params
      params.require(:payment).permit(:outcome, :memo, :user_id)
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
            unit_amount:  (@request.bids.where(vendor_id: @request.vendor_id).first.amount * 100).to_i,
            product: @request.services.first.stripe_product_id,
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
