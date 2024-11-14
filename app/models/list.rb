class List < ApplicationRecord
    # Attention, l'ordre importe : je peux pas faire through "bookmark" si j'ai pas
    # dit qu'elle avait des bookmarks
    
    has_many :bookmarks
    has_many :movies, through: :bookmarks, dependent: :destroy

    validates :name, presence: {
      message: "You must name your list"
    }
    validates :name, uniqueness: {
      message: "Lists must have unique name"
    }

end
