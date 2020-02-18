class Api::V1::UsersController < ApplicationController
    def create # to be modified depending on client-side
        @user = User.create(user_params)
        if @user.valid?
            @token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: @token }, status: :created
        else
        render json: { message: @user.errors.full_messages[0] }, status: :not_acceptable
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password) #possible to add bio attribute to initialize
    end   
end
