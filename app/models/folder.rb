class Folder < ApplicationRecord
  has_many :notes, dependent: :destroy
  belongs_to :user

  validates :name, :user, presence: true
end
