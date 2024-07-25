module Customer
  class UsersController < ApplicationController
    layout "customer"
    def show
      @user = User.find(params[:id])
    end
  end
end
