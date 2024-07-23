module Vendor
  class UsersController < ApplicationController
    layout "vendor"
    def show
      @user = User.find(params[:id])
    end
  end
end
