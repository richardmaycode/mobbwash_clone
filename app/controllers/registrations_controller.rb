class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_authenticated, only: [ :new ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(user_type: "customer", region_id: 1)) # TODO: change these merge defaults to be location and user registration dependent

    if @user.save
      after_registration(@user)

      redirect_to root_path, notice: "Logged in."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :handle, :password)
  end
end
