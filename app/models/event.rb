class Event < ApplicationRecord
  belongs_to :user

  private

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true
  validates :user, presence: true
end
