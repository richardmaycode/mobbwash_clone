module Vendor
  class RequestsController < ApplicationController
    layout "vendor"
    before_action :set_user # FIXME: Switch to current
    def index
      filter = params[:filter].presence || "requested"

      case filter
      when "requested"
        @pagy, @requests = pagy(Request.where(status: "requested"))
        @page_title = "Available"
      when "assigned"
        @pagy, @requests = pagy(@user.assigned_requests.where(status: "assigned"))
        @page_title = "Active"
      when "completed"
        @pagy, @requests = pagy(@user.assigned_requests.where(status: "completed"))
        @page_title = "Completed"
      else
        @pagy, @requests = pagy(Request.where(status: "requested"))
        @page_title = "Available"
      end
    end

    def set_user
      @user = User.second
    end
  end
end
