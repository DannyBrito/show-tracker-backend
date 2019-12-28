class Api::V1::UsersController < ApplicationController
    # uncomment once authentifaction working
    # skip_before_action :authorized, only: [:create]

    def create # to be modified depending on client-side
        @user = User.create(user_params)
        if @user.valid?
        @token = encode_token({ user_id: @user.id })
        render json: { user: @user, jwt: @token }, status: :created
        else
        render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

      private

      def user_params
        params.require(:user).permit(:username, :password) #possible to add bio attribute to initialize
      end    
end