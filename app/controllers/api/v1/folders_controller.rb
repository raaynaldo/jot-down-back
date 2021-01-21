class Api::V1::FoldersController < ApplicationController
  def get_folders
    render json: current_user.folders.order(:name), root: "folders", adapter: :json, each_serializer: FolderSerializer, status: :ok
  end

  def create_folder
    folder = Folder.new(name: params[:name], user_id: current_user.id)
    if folder.save!
      render json: { id: folder.id }, status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  def update_folder
    folder = Folder.find(params[:id])
    folder.name = params[:name]
    if folder.save!
      render status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  def delete_folder
    folder = Folder.find(params[:id])
    folder.destroy()
    render status: :ok
  end
end
