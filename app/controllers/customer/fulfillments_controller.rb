class Customer::FulfillmentsController < ApplicationController
  def show
    session = Stripe::Checkout::Session.retrieve(id: params[:session_id])

    @request = Request.find(session.metadata.request_id)
    @request.update_attribute(:status, "completed")

    redirect_to customer_requests_path, notice: "Payment Captured!"
  rescue Stripe::InvalidRequestError => e
    redirect_to customer_requests_path, notice: "Sorry we could not process your payment: #{e.message}"
  end
end
