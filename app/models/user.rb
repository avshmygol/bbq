class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :events

  private

  validates :name, presence: true, uniqueness: true, length: { maximum: 35 }
  validates :name, format: { with: /\A[0-9a-z_]+\z/i }
end
