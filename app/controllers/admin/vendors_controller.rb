class Admin::VendorsController < ApplicationController
  layout "admin"
  def index
    @pagy, @vendors = params.has_key?(:query) ? pagy(User.all.vendor.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")) : pagy(User.all.vendor)

    if turbo_frame_request?
      render partial: "vendors", customers: @vendors
    else
      render :index
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def delete
  end
end
