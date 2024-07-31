module Vendor
  module Bids
    class CancellationsController < ApplicationController
      def create
        @bid = Bid.find(params[:bid_id])
        @bid.update_attribute(:status, "cancelled")
        @bid.touch(:last_status_update)
        redirect_to vendor_bids_path, notice: "Bid Canceled"
      end
    end
  end
end
