class User < ApplicationRecord
  has_many :events

  private

  validates :name, presence: true, uniqueness: true, length: { maximum: 35 }
  validates :name, format: { with: /\A[0-9a-z_]+\z/i }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :email, format: { with: /\A[a-z0-9\-_.]+@[a-z0-9\-_.]+\z/i }
end
