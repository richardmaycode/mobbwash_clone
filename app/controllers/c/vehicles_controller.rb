module C
  class VehiclesController < ApplicationController
    before_action :set_user

    def index
      @action = { btm_btn_show: true, btm_btn_txt: "Add Vehicle", btm_btn_link: new_c_user_vehicle_path(@user) }
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
        redirect_to [ :c, @user, :vehicles ]
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
        redirect_to [ :c, @user, :vehicles ]
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @vehicle = Vehicle.find(params[:id])
      if @vehicle.default
        puts "I'm Default!!!"
        redirect_to [ :c, @user, :vehicles ], notice: "Cannot delete default vehicle, set another vehicle to default before attempting deletion."
      else
        @vehicle.destroy
        redirect_to [ :c, @user, :vehicles ]
      end


      # FIXME: Update to allow for soft delete if requests exist
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def vehicle_params
      params.require(:vehicle).permit(:nickname, :make, :model, :color, :license_plate)
    end
  end
end
