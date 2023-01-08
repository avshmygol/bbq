class Photo < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :photo, presence: true

  # Добавляем аплоадер фотографий, чтобы заработал carrierwave
  mount_uploader :photo, PhotoUploader

  # Этот scope нужен нам, чтобы отделить реальные фотки от болваной см. events_controller
  scope :persisted, -> { where "id IS NOT NULL" }
end
