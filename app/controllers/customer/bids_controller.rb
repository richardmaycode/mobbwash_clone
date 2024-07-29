module Customer
  class BidsController < ApplicationController
    before_action :set_request
    def index
      @bids = @request.bids
    end

    def accept
      @bid = Bid.find(params[:id])

      if @request.update(vendor_id: @bid.vendor_id, status: "assigned")
        redirect_to customer_request_path(@request), notice: "Vendor Notified of bid acceptance"
      else
        redirect_to customer_request_bids_path(@request), status: :unprocessable_entity, alert: "Something went wrong."
      end
    end

    private

    def set_request
      @request = Request.find(params[:request_id])
    end
  end
end
