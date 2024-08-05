class Customer::PaymentMethodsController < ApplicationController
  layout "customer"
  def index
    @payment_methods = Current.user.payment_processor.payment_methods.order(default: :desc)
  end
  def new
    set_checkout_session
    puts @checkout_session
  rescue Pay::Error => e
    flash[:alert] = e.message
    render :new
  end

  def add
    session = Stripe::Checkout::Session.retrieve(id: params[:session_id])
    setup_intent = Stripe::SetupIntent.retrieve(session.setup_intent)

    Current.user.payment_processor.update_payment_method(setup_intent[:payment_method])

    redirect_to session.metadata.redirect_path, notice: "Payment Method Added"
  end

  def set_checkout_session
    payment_processor = Current.user.set_payment_processor(:stripe)

    args = {
      mode: :setup,
      ui_mode: :embedded,
      currency: "usd",
      # metadata: { request_id: @request.id },
      metadata: { redirect_path: customer_user_path(Current.user) },
      return_url: customer_payment_methods_add_url
    }

    @checkout_session = payment_processor.checkout(**args)
  end
end
