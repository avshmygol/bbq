class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, length: { maximum: 100 }, unless: -> { user.present? }
  validates :user_email, presence: true, length: { maximum: 100 }, format: Devise.email_regexp, unless: -> { user.present? }

  validate :check_subscription_of_author, if: -> { user.present? }
  validate :check_forgery_email, unless: -> { user.present? }

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

  def check_subscription_of_author
    errors.add(:user, :error_subscription_of_author) if user == event.user
  end

  def check_forgery_email
    errors.add(:user_email, :error_forgery_email) unless User.find_by(email: user_email).nil?
  end
end
