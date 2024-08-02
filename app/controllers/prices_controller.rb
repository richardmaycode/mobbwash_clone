class PricesController < ApplicationController
  def show
    puts params[:service_id]
    @price = Price.where(region_id: params[:region_id], service_id: params[:service_id], vehicle_size_id: params[:vehicle_size_id]).first
    respond_to do |format|
      format.json
      format.html { redirect_to customer_requests_path }
    end
  end
end
