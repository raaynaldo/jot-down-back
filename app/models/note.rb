class Note < ApplicationRecord
  belongs_to :folder
  has_many :note_tags
  has_many :tags, through: :note_tags

  scope :archived_by_user, ->(user_id) { joins(:folder).where("notes.deleted = false and notes.archived = ? and folders.user_id = ?", true, user_id) }
  scope :deleted_by_user, ->(user_id) { joins(:folder).where("notes.deleted = ? and folders.user_id = ?", true, user_id) }
  scope :with_folder_id, ->(folder_id) { joins(:folder).where("notes.deleted = false and notes.archived = false and folders.id = ?", folder_id) }
end
