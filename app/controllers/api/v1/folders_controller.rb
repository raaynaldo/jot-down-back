class Api::V1::FoldersController < ApplicationController
  def get_folders
    render json: current_user.folders, root: "folders", adapter: :json, each_serializer: FolderSerializer, status: :ok
  end
end
