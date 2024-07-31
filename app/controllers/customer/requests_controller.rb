module Customer
  class RequestsController < ApplicationController
    layout "customer"
    before_action :set_user
    def index
      @pagy, @requests = pagy(@user.requests.includes(:services, :vehicle, :vendor))
      send_test_notification
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
        redirect_to customer_requests_path(), notice: "Request successfully created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = Current.user
    end


    def request_params
      params.require(:request).permit(:scheduled, :location, :location_lat, :location_long, :vehicle_id, :access_details, :service_ids)
    end

    def send_test_notification
      if ps = PushSubscription.first
        WebPush.payload_send(
          message: "{\"title\":\"Test Title\",\"options\":{\"body\":\"Body of text\"}}",
          endpoint: ps.endpoint,
          p256dh: ps.p256dh_key,
          auth: ps.auth_key,
          vapid: {
            subject: "mailto:info@woodyspaper.com",
            public_key: Rails.application.credentials.dig(:webpush, :public_key),
            private_key: Rails.application.credentials.dig(:webpush, :private_key)
          }
        )
      end
    end
  end
end
