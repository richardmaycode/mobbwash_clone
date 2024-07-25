module Customer
  class RequestsController < ApplicationController
    layout "customer"
    before_action :set_user
    def index
      @pagy, @requests = pagy(Request.includes(:services, :vehicle, :vendor).where(customer_id: Current.user.id))
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
        redirect_to [ :customer, @user, :requests ]
      else
        render :new
      end
    end

    private

    def set_user
      @user = User.includes(:vehicles).find(params[:user_id])
    end


    def request_params
      params.require(:request).permit(:scheduled, :location, :location_lat, :location_long, :vehicle_id, :access_details, :service_ids)
    end
  end
end
