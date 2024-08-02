class Customer::PaymentMethodsController < ApplicationController
  def new
    @intent = Stripe::SetupIntent.create(customer: Current.user.pay_customers.where(processor: "stripe").first.processor_id)
    puts @intent
  end

  def create
  end
end
