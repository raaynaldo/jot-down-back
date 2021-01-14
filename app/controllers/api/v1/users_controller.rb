class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    new_user = User.new(user_params)
    if new_user.save
      token = encode_token(user_id: new_user.id)
      render json: { user: UserSerializer.new(new_user), token: token }, status: :created
    else
      render json: { message: "failed to create user", errors: new_user.errors }, status: :not_acceptable
    end
  end

  def show
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
  end
end
