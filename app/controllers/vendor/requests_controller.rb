module Vendor
  class RequestsController < ApplicationController
    def index
      @pagy, @requests = pagy(Request.where(status: "requested"))
    end
  end
end
