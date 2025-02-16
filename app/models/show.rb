class Show < ApplicationRecord
  belongs_to :movie
  has_many :tickets, dependent: :destroy

  validates :date, :time, :seats, :price, :available_seats, presence: true
  validates :movie_id, presence: true  # Ensure show is linked to an existing movie
end
