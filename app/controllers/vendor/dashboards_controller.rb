module Vendor
  class DashboardsController < ApplicationController
    layout "vendor"
    before_action :set_user # FIXME: Update to use current pattern
    def show
    end

    private

    def set_user
      @user = User.second
    end
  end
end
