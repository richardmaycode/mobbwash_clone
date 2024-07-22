module C
  class RequestsController < ApplicationController
    before_action :set_user, only: [ :new, :create ]
    def index
      @pagy, @requests = pagy(Request.where(customer_id: 1))
    end

    def new
      @request = @user.requests.new
      @services = Service.active
    end

    def create
      @request = @user.requests.new(request_params)
      @services = Service.active

      if @request.save
        redirect_to [ :c, @user, :requests ]
      else
        render :new
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end


    def request_params
      params.require(:request).permit(:scheduled, :location, :location_lat, :location_long, :vehicle_id, :access_details, :service_ids)
    end
  end
end
