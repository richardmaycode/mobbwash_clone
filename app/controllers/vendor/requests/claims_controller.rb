module Vendor
  class Requests::ClaimsController < ApplicationController
    layout "vendor"
    before_action :set_user
    before_action :set_request
    def new; end

    def create
      if @request.status == "unassigned" && @request.vendor_id == nil
        if @request.update(status: "assigned", vendor_id: @user.id)
          redirect_to vendor_request_path(@request), notice: "Request Claimed!"
        else
          render :new, status: :unprocessable_entity, notice: "Unknown Error"
        end

      else
        render :new, status: :unprocessable_entity, notice: "This Request is no longer available."
      end
    end

    private

    def set_user
      @user = User.second
    end

    def set_request
      @request = Request.includes(:customer, :price).find(params[:request_id])
    end
  end
end
