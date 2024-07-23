
  class C::Vehicles::DefaultsController < ApplicationController
    before_action :set_user
    def create
      @user.vehicles.where(default: true).sole.update_column(:default, false)
      Vehicle.find(params[:vehicle_id]).update_column(:default, true)
      redirect_to c_user_vehicles_path(@user)
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
