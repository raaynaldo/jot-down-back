class Tag < ApplicationRecord
    has_many :note_tags
    has_many :notes, through: :note_tags

    validates :name, presence: true, uniqueness: true

    before_save :lowercase_name

    private
    def lowercase_name
        self.name = self.name.downcase
    end
end
