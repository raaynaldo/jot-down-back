class Api::V1::NotesController < ApplicationController
  def get_notes
    if params[:type] === Note::FOLDER_TYPES[:folder]
      notes = Note.with_folder_id(params[:id])
    elsif params[:type] === Note::FOLDER_TYPES[:archived]
      notes = Note.archived_by_user(current_user.id)
    elsif params[:type] === Note::FOLDER_TYPES[:trash]
      notes = Note.deleted_by_user(current_user.id)
    elsif params[:type] === Note::FOLDER_TYPES[:tag]
      notes = Note.with_tag_id_by_user(params[:id], current_user.id)
    end
    render json: notes, root: "notes", adapter: :json, each_serializer: NoteSerializer, status: :ok
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
    if note.save!
      render status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  def add_note
    if params[:type] === Note::FOLDER_TYPES[:folder]
      note = Note.new(folder_id: params[:id])
    elsif params[:type] === Note::FOLDER_TYPES[:tag]
      tag = Tag.find(params[:id])
      note = Note.new(body: "\n##{tag.name}", tags: [tag], folder_id: current_user.folders.first.id)
    end
    if note.save!
      render json: { note: { id: note.id } }, status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  def archive_note
    note = Note.find(params[:id])
    note.archived = params[:archive]
    if note.save!
      render status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  def delete_note
    note = Note.find(params[:id])
    note.deleted = params[:delete]
    if note.save!
      render status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  def move_note
    note = Note.find(params[:id])
    note.folder_id = params[:folder_id]
    if note.save!
      render status: :ok
    else
      render json: { message: "save failed" }, status: :not_acceptable
    end
  end

  private

  def note_params
    params.require("note").permit(:id, :body, :title)
  end
end
