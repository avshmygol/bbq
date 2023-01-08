class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true

  validates :user_name, presence: true, length: { maximum: 100 }, unless: -> { user.present? }
end