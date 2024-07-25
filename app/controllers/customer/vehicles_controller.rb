module Customer
  class VehiclesController < ApplicationController
    layout "customer"

    before_action :set_user

    def index
      @vehicles = @user.vehicles
    end

    def show
      @vehicle = Vehicle.find(params[:id])
    end

    def new
      @vehicle = @user.vehicles.new
    end

    def create
      @vehicle = @user.vehicles.new(vehicle_params)

      if @vehicle.save
        redirect_to [ :customer, :vehicles ], notice: "Vehicle successfully created"
      else
        render :new
      end
    end

    def edit
      @vehicle = Vehicle.find(params[:id])
    end

    def update
      @vehicle = Vehicle.find(params[:id])

      if @vehicle.update(vehicle_params)
        redirect_to [ :customer, :vehicles ]
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @vehicle = Vehicle.find(params[:id])
      if @vehicle.default
        redirect_to [ :customer, :vehicles ], notice: "Cannot delete default vehicle, set another vehicle to default before attempting deletion."
      else
        @vehicle.destroy
        redirect_to [ :customer, :vehicles ]
      end


      # FIXME: Update to allow for soft delete if requests exist
    end

    private

    def set_user
      @user = Current.user
    end

    def vehicle_params
      params.require(:vehicle).permit(:nickname, :make, :model, :color, :license_plate)
    end
  end
end
