class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :last_updated_at, :link, :link_active
end
