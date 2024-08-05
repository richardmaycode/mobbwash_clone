module Customer
  class RequestsController < ApplicationController
    layout "customer"

    before_action :set_user

    def index
      @pagy, @requests = pagy(@user.requests.includes(:vendor))
    end

    def show
      @request = Request.find(params[:id])
    end

    def new
      @request = @user.requests.new(location_lat:  26.12, location_long: -80.14)
      @services = Service.active
    end

    def create
      @request = @user.requests.new(request_params)
      @services = Service.active

      if @request.save
        if User.last.payment_processor.payment_methods.empty?
          redirect_to new_customer_payment_method_path
        else
          redirect_to new_customer_request_authorization_path(request_id: @request.id)
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = Current.user
    end


    def request_params
      params.require(:request).permit(:scheduled, :location, :location_lat, :location_long, :price_id, :access_details)
    end
  end
end
