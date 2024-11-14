class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, presence: {
    message: "You must give a comment to your bookmark"
  }
  validates :comment, length: {
    minimum: 6
  }
  validates_associated :movie, presence: {
    message: "Make sure you have selected a movie"
  }
  validates_associated :list, presence: {
    message: "Make sure you have selected a list"
  }

  validates :movie_id, uniqueness: {
    scope: :list_id,
    message: "A bookmark refers to a unique couple movie/list"
  }

end
