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

  def update_name
    user = current_user
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    if user.save
      render json: { user: UserSerializer.new(user) }, status: :ok
    else
      render json: { message: "failed to update name", errors: new_user.errors }, status: :not_acceptable
    end
  end

  def update_picture
    user = current_user
    if params[:pictureType] == User::PICTURE_TYPES[:file]
      user.picture_active_record.attach(params[:picture])
      user.picture = url_for(user.picture_active_record)
    elsif params[:pictureType] == User::PICTURE_TYPES[:camera]
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new((Base64.decode64(params[:picture].split(",")[1]))),
        filename: "#{current_user.first_name + current_user.last_name}.png",
        content_type: "image/png",
      )
      user.picture_active_record.attach(blob)
      user.picture = url_for(user.picture_active_record)
    elsif params[:pictureType] == User::PICTURE_TYPES[:clear]
      user.picture_active_record.purge
      user.picture = ""
    end

    if user.save
      render json: { picture: user.picture }, status: :ok
    else
      render json: { message: "failed to update picture", errors: new_user.errors }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
  end
end
