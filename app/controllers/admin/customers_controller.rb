class Admin::CustomersController < ApplicationController
  layout "admin"

  before_action :set_customer, only: %i[show edit update destroy]
  def index
    @pagy, @customers = params.has_key?(:query) ? pagy(User.all.customer.where("name LIKE ?", "%#{params[:query]}%")) : pagy(User.all.customer.where("name LIKE ?", "%#{params[:search]}%"))

    if turbo_frame_request?
      render partial: "customers", customers: @customers
    else
      render :index
    end
  end

  def show; end

  def new
  end

  def edit; end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_customer
    @customer = User.find(params[:id])
  end

  def customer_params
    params.require(:user).permit()
  end
end
