module Customer
  class RequestsController < ApplicationController
    layout "customer"
    before_action :set_user
    def index
      @pagy, @requests = pagy(@user.requests.includes(:services, :vehicle, :vendor))
    end

    def show
      @request = Request.find(params[:id])
    end

    def new
      @request = @user.requests.new
      @services = Service.active
    end

    def create
      @request = @user.requests.new(request_params)
      @services = Service.active

      if @request.save
        redirect_to new_customer_payment_path(request_id: @request.id), notice: "Request successfully created!"
      else
        render :new
      end
    end

    private

    def set_user
      @user = Current.user
    end


    def request_params
      params.require(:request).permit(:scheduled, :location, :location_lat, :location_long, :vehicle_id, :access_details, :service_ids)
    end
  end
end
