module Vendor
  class RequestsController < ApplicationController
    layout "vendor"
    before_action :set_user # FIXME: Switch to current
    before_action :set_request, only: %w[ show ]
    def index
      filter = params[:filter].presence || "available"

      case filter
      when "assigned"
        @pagy, @requests = pagy(@user.assigned_requests.includes(:price, :customer).where(status: filter).order(scheduled: :ASC), limit: 10)
        @page_title = "Active"
      when "completed"
        @pagy, @requests = pagy(@user.assigned_requests.includes(:price, :customer).where(status: filter).order(scheduled: :ASC), limit: 10)
        @page_title = "Completed"
      else
        @pagy, @requests = pagy(Request.includes(:price, :customer).where(status: filter).order(scheduled: :ASC), limit: 10)
        @page_title = "Available"
      end
    end

    def show
    end

    def set_user
      @user = Current.user
    end

    private
    def set_request
      @request = Request.includes(:price, :customer, :cancellation).find(params[:id])
    end
  end
end
