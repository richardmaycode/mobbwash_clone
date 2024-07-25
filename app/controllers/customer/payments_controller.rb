module Customer
  class PaymentsController < ApplicationController
    layout "customer"
    before_action :set_user
    def new
      @request = Request.find(params[:request_id])
      @payment = Payment.new
    end

    def create
      @request = Request.find(params[:request_id])
      @payment = Payment.new(payment_params)

      if @payment.save
        if @payment.outcome == "success"
          @request.update_column(:status, "available")
          redirect_to customer_request_path(@request), notice: "Payment Successful"
        else
          redirect_to new_payment_path(request_id: @request.id)
        end

      end
    end

    private

    def set_user
      @user ||= Current.user
    end

    def payment_params
      params.require(:payment).permit(:outcome, :memo, :user_id)
    end
  end
end
