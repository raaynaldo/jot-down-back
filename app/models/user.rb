class User < ApplicationRecord
  has_secure_password
  has_many :folders, -> { includes :notes }, dependent: :destroy
  has_one_attached :picture_active_record

  validates :first_name, :last_name, presence: true
  validates :email, :username, presence: true, uniqueness: true

  PICTURE_TYPES = {
    file: "0",
    camera: "1",
    clear: "2",
  }

  after_create :create_default_folder
  after_initialize :init

  def full_name
    self.first_name + " " + self.last_name
  end

  def tags
    Tag.with_user_id(self.id)
  end

  def notes
    Note.joins(:folder).where("folders.user_id = ?", self.id)
  end

  private

  def init
    self.picture ||= ""
  end

  def create_default_folder
    self.folders.build(name: "Main")
      .notes.build(title: "Welcome", body: "Welcome to Jot Down")
      .note_tags.build(tag_id: Tag.find_by(name: "welcome").id)

    self.folders.first.notes.build(cheat_sheet).note_tags.build(tag_id: Tag.find_by(name: "welcome").id)
    self.save!
  end

  def cheat_sheet
    file = File.join(Rails.root, "app", "files", "markdown-cheat-sheet.md")
    note = {
      title: "Markdown Cheat Sheet",
      body: File.read(file),
    }
  end
end
