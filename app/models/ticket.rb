class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validates :user_id, presence: true
  validates :show_id, presence: true
  validates :confirmation_number, presence: true
  validates :status, presence: true

  validate :available_seats_check, on: :create

  private

  def available_seats_check
    if self.show.available_seats < self.number_of_tickets
      errors.add(:number_of_tickets, "cannot exceed the available seats.")
    end
  end
end