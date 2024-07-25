
  class Customer::Vehicles::DefaultsController < ApplicationController
    before_action :set_user
    def create
      @user.vehicles.update_all(default: false)

      Vehicle.find(params[:vehicle_id]).update_column(:default, true)
      redirect_to customer_vehicles_path(@user)
    end

    private

    def set_user
      @user = Current.user
    end
  end
