class Note < ApplicationRecord
  belongs_to :folder
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags

  scope :with_folder_id, ->(folder_id) { joins(:folder).where("notes.deleted = false and notes.archived = false and folders.id = ?", folder_id).order(last_updated_at: :desc) }
  scope :archived_by_user, ->(user_id) { joins(:folder).where("notes.deleted = false and notes.archived = true and folders.user_id = ?", user_id).order(last_updated_at: :desc) }
  scope :deleted_by_user, ->(user_id) { joins(:folder).where("notes.deleted = true and folders.user_id = ?", user_id).order(last_updated_at: :desc) }
  scope :with_tag_id_by_user, ->(tag_id, user_id) { joins(:tags).joins(:folder).where("notes.deleted = false and notes.archived = false and tags.id = ? and folders.user_id = ?", tag_id, user_id).order(last_updated_at: :desc) }

  FOLDER_TYPES = {
    folder: "folder",
    archived: "archived",
    trash: "trash",
    tag: "tag",
  }
  
  after_initialize  :init

  private
  def init
    self.title ||= ""
    self.body ||= ""
    self.last_updated_at ||= DateTime.now()
    self.archived ||= false
    self.deleted ||= false
    self.link ||= ""
    self.link_active ||= false
  end
end
