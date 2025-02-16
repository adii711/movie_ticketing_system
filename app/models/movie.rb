class Movie < ApplicationRecord
  has_many :shows, dependent: :destroy  # A movie can have many shows

end