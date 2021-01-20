class Api::V1::NoteTagsController < ApplicationController
  def add_note_tag
    tag = Tag.find_or_create_by(name: params[:name])
    note_tags = NoteTag.create(note_id: params[:id], tag_id: tag.id)
    render status: :ok
  end

  def remove_note_tag
    tag = Tag.find_by(name: params[:name])
    note_tags = NoteTag.find_by(note_id: params[:id], tag_id: tag.id)
    note_tags.destroy
    render status: :ok
  end
end
