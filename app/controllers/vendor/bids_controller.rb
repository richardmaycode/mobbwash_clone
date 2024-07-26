module Vendor
  class BidsController < ApplicationController
    before_action :set_request

    def new
      @bid = Bid.new(vendor_id: Current.user)
    end

    private

    def set_request
      @request = Request.find(params[:request_id])
    end
  end
end
