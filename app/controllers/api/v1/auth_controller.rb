class Api::V1::AuthController < ApplicationController
    # skip_before_action :authorized, only: [:create]
 
  def create
    @user = User.find_by(username: user_login_params[:username])
    #User#authenticate comes from BCrypt
    if @user && @user.authenticate(user_login_params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })
      render json: { user: @user.get_attributes, token: token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def auto_login
    if current_user
      render json: {user: current_user.get_attributes}
    else
        render json: {errors: "User not found. Please login again. "}
    end
  end
 
  private
 
  def user_login_params
    # params { user: {username: 'Chandler Bing', password: 'hi' } }
    params.require(:user).permit(:username, :password)
  end
end
