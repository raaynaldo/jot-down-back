class Folder < ApplicationRecord
  has_many :notes, dependent: :destroy
  belongs_to :user

  validates :name, :user_id, presence: true
end
