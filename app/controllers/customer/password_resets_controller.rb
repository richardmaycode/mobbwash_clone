module Customer
    class PasswordResetsController < ApplicationController
      before_action :set_user
      def new; end
      def create
        if @user.update(user_params)
          respond_to do |format|
            format.html { redirect_to customer_user_path(@user), notice: "Password updated" }
            format.turbo_stream { flash.now[:notice] = "Password updated" }
          end
        else
          render :new, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user ||= Current.user
      end

      def user_params
        params.require(:user).permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: "")
      end
    end
end
