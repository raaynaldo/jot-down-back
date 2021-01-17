class Api::V1::NotesController < ApplicationController
  def get_notes_by_folder
    notes = Note.with_folder_id(params[:id])
    render_notes(notes)
  end

  def get_notes_in_archived
    notes = Note.archived_by_user(current_user.id)
    render_notes(notes)
  end

  def get_notes_in_trash
    notes = Note.deleted_by_user(current_user.id)
    render_notes(notes)
  end

  def get_notes_by_tag
    notes = Note.with_tag_id_by_user(params[:id], current_user.id)
    render_notes(notes)
  end

  def get_note
    note = Note.find(params[:id])
    render json: { note: NoteSerializer.new(note) }, status: :ok
  end

  def save_note
    note = Note.find(note_params[:id])
    note.title = note_params[:body].split("\n", 2)[0]
    note.body = note_params[:body]
    note.last_updated_at = DateTime.now()
    if note.save
      render status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  private

  def note_params
    params.require("note").permit(:id, :body, :title)
  end

  def render_notes(notes)
    render json: notes, root: "notes", adapter: :json, each_serializer: NoteSerializer, status: :ok
  end
end
