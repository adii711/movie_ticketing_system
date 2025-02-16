class Show < ApplicationRecord
  belongs_to :movie
  has_many :tickets

  validates :date, :time, :seats, :price, presence: true
  validates :movie_id, presence: true  # Ensure show is linked to an existing movie
end
