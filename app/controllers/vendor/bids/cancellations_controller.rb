module Vendor
  module Bids
    class CancellationsController < ApplicationController
      def create
        @bid = Bid.find(params[:bid_id])
        @bid.update_attribute(:status, "cancelled")
        redirect_to vendor_bids_path, notice: "Bid Canceled"
      end
    end
  end
end
