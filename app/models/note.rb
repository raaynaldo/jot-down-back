class Note < ApplicationRecord
  belongs_to :folder
  has_many :note_tags
  has_many :tags, through: :note_tags

  scope :with_folder_id, ->(folder_id) { joins(:folder).where("notes.deleted = false and notes.archived = false and folders.id = ?", folder_id) }
  scope :archived_by_user, ->(user_id) { joins(:folder).where("notes.deleted = false and notes.archived = true and folders.user_id = ?", user_id) }
  scope :deleted_by_user, ->(user_id) { joins(:folder).where("notes.deleted = true and folders.user_id = ?", user_id) }
  scope :with_tag_id_by_user, ->(tag_id, user_id) { joins(:tags).joins(:folder).where("notes.deleted = false and notes.archived = false and tags.id = ? and folders.user_id = ?", tag_id, user_id) }
end
