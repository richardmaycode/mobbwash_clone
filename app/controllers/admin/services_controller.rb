class Admin::ServicesController < ApplicationController
  layout "admin"
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
end
