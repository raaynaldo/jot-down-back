class User < ApplicationRecord
  has_secure_password
  has_many :folders, -> { includes :notes }

  validates :first_name, :last_name, presence: true
  validates :email, :username, presence: true, uniqueness: true

  after_create :create_default_folder

  def full_name
    self.first_name + " " + self.last_name
  end

  private

  def create_default_folder
    self.folders.build(name: "Main")
      .notes.build(title: "Welcome", body: "Welcome to Jot Down", archived: false, last_updated_at: DateTime.now(), deleted: false, link: "", link_active: false)
      .tags.build(name: "welcome")
    self.save!
  end
end
