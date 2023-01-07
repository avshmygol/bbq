class User < ActiveRecord::Base
  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: { maximum: 35 }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # after_commit гарантирует что пользователь создался в БД
  after_commit :link_subscriptions, on: :create

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
