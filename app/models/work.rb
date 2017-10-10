class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  LEGAL_CATEGORIES = ["album", "book", "movie"]

  def self.all_categories
    LEGAL_CATEGORIES
  end
end
