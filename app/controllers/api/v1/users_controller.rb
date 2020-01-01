class Api::V1::UsersController < ApplicationController
    # uncomment once authentifaction working
    # skip_before_action :authorized, only: [:create]

    def create # to be modified depending on client-side
        @user = User.create(user_params)
        if @user.valid?
        @token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: @token }, status: :created
        else
        render json: { message: @user.errors.full_messages[0] }, status: :not_acceptable
        end
    end

    def auto_login   
      if session_user
          render json: {user: session_user}
      else
          render json: {errors: "User not found. Please login again. "}
      end
    end

      private

      def user_params
        params.require(:user).permit(:username, :password) #possible to add bio attribute to initialize
      end    
end
