module Vendor
  class BidsController < ApplicationController
    layout "vendor"

    before_action :set_request, only: [ :new, :create ]
    before_action :check_for_existing_bid, only: [ :new ]

    def index
      @bids = Current.user.bids
    end

    def new
      @bid = @request.bids.new(vendor_id: Current.user)
    end

    def create
      @bid = @request.bids.new(bid_params.merge(vendor_id: Current.user.id))
      if @bid.save
        redirect_to vendor_requests_path, notice: "Bid submitted"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_request
      @request = Request.includes(:vehicle, :services).find(params[:request_id])
    end

    def bid_params
      params.require(:bid).permit(:request_id, :vendor_id, :amount, :work_date)
    end

    def check_for_existing_bid
      if  @request.bids.pluck(:id).include? params[:request_id].to_i
        redirect_to vendor_requests_path(filter: "available"), notice: "You have already submitted a bid for this request"
      end
    end
  end
end
