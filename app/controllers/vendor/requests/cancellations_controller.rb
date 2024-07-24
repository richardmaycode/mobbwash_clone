module Vendor
  module Requests
    class CancellationsController < ApplicationController
      layout "vendor"
      before_action :set_request
      def new
        @cancellation = @request.build_cancellation
      end

      def create
        @cancellation = @request.build_cancellation(cancellation_params)
        if @cancellation.save
          @request.update(status: "cancelled")
          redirect_to [ :vendor, @request ], notice: "Cancellation recorded"
        else
          render :new, status: :unprocessable_entity
        end
      end

      private

      def set_request
        @request = Request.find(params[:request_id])
      end

      def cancellation_params
        params.require(:cancellation).permit(:vendor_id, :reported, :notes)
      end
    end
  end
end
