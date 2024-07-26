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

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end
end
