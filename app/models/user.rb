class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, length: { maximum: 100 }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :events, dependent: :restrict_with_exception
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  # after_commit гарантирует что пользователь создался в БД
  after_commit :link_subscriptions, on: :create

  # добавляем аплоадер аватарок, чтобы заработал carrierwave
  mount_uploader :avatar, AvatarUploader

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
