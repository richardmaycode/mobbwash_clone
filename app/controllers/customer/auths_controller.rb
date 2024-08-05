module Customer
  class AuthsController < ApplicationController
    def show
      session = Stripe::Checkout::Session.retrieve(id: params[:session_id])
      setup_intent = Stripe::SetupIntent.retrieve(session.setup_intent)

      @request = Request.find(session.metadata.request_id)

      Current.user.payment_processor.update_payment_method(setup_intent[:payment_method])
      Current.user.payment_processor.charge(@request.price.amount, capture_method: "manual")

      redirect_to customer_requests_path, notice: "Payment Method Captured!"
    end
  end
end
