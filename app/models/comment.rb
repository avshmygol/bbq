class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, optional: true

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  private

  validates :body, presence: true

  validates :user_name, presence: true, length: { maximum: 100 }, unless: -> { user.present? }
end
