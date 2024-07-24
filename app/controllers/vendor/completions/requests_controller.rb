module Vendor::Completions
  class RequestsController < ApplicationController
    layout "vendor"
    before_action :set_request
    def edit; end

    def update
      @request.assign_attributes(request_params)
      if @request.save(context: :completion)
        redirect_to [ :vendor, @request ], notice: "Request Marked Complete"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:completed, :completion_notes, :status)
    end
  end
end
