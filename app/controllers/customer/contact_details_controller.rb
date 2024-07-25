module Customer
  class ContactDetailsController < ApplicationController
    before_action :set_user
    def edit; end
    def update
      if @user.update(user_params)
        respond_to do |format|
          format.html { redirect_to customer_user_path(@user), notice: "Contact Details updated" }
          format.turbo_stream { flash.now[:notice] = "Contact Details updated" }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user ||= Current.user
    end

    def user_params
      params.require(:user).permit(:address_line_1, :address_line_2, :city, :state, :postal_code, :phone_number, :email)
    end
  end
end
