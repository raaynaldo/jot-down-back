class Tag < ApplicationRecord
  has_many :note_tags
  has_many :notes, through: :note_tags

  validates :name, presence: true, uniqueness: true

  before_save :lowercase_name

  scope :with_user_id, ->(user_id) { joins(:notes => :folder).where("notes.deleted = false and notes.archived = false and folders.user_id = ?", user_id).distinct }

  private

  def lowercase_name
    self.name = self.name.downcase
  end
end
