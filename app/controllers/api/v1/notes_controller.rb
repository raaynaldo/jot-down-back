class Api::V1::NotesController < ApplicationController
  def get_notes_by_folder
    notes = Note.with_folder_id(params[:id])
    render json: notes, root: "notes", adapter: :json, each_serializer: NoteSerializer, status: :ok
  end
end
