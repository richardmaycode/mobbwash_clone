class Admin::ServicesController < ApplicationController
  layout "admin"

  before_action :set_service, only: [ :show, :edit, :update ]
  def index
    @services = Service.all
  end

  def show
  end

  def new
  end

  def edit; end

  def create
  end

  def update
    if @service.update(service_params)
      redirect_to admin_services_path, notice: "Service updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :min_price, :max_price, :avg_price)
  end
end
