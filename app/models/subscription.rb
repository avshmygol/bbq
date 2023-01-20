class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, length: { maximum: 100 }, unless: -> { user.present? }
  validates :user_email, presence: true, length: { maximum: 100 }, format: Devise.email_regexp, unless: -> { user.present? }

  validate :filter_subscription

  # для данного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }

  # для данного event_id один email может использоваться только один раз (если нет юзера, анонимная подписка)
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def filter_subscription
    if user.present?
      errors.add(:base, :error_author) if user == event.user
    else
      errors.add(:base, :error_email) unless User.find_by(email: user_email).nil?
    end
  end
end
