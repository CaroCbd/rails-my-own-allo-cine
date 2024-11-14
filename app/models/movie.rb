class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, presence: {
    message: "Your movie must have a title"
  }
  validates :title, uniqueness: {
    message: "Your movie must have a unique title"
  }
  # validates :title, uniqueness: true
  validates :overview, presence: {
    message: "Your must give an overview for your movie"
  }
end
