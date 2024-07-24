class Admin::RequestsController < ApplicationController
  layout "admin"
  def index
    @pagy, @requests = params.has_key?(:query) ? pagy(Request.all.where("request_number LIKE ?", "%#{params[:query]}%")) : pagy(Request.all)

    if turbo_frame_request?
      render partial: "requests", requests: @requests
    else
      render :index
    end
  end

  def show
  end

  def new
  end

  def update
  end
end
