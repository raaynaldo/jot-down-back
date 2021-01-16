class Api::V1::TagsController < ApplicationController
  def get_tags
    render json: current_user.tags, root: "tags", adapter: :json, each_serializer: TagSerializer, status: :ok
  end
end
