# (с) goodprogrammer.ru
#
# Модель Пользователя
class User < ActiveRecord::Base
  # Добавляем к юзеру функции Девайза, перечисляем конкретные наборы функций
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :events

  validates :name, presence: true, length: {maximum: 35}

  # При создании нового юзера (create), перед валидацией объекта выполнить
  # метод set_name
  before_validation :set_name, on: :create

  private

  # Задаем юзеру случайное имя, если оно пустое
  def set_name
    self.name = "Пользователь №#{rand(777)}" if self.name.blank?
  end
end
