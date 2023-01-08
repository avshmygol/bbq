# (с) goodprogrammer.ru
#
# Базовый класс для всех мэйлеров приложения
class ApplicationMailer < ActionMailer::Base
  # обратный адрес всех писем по умолчанию
  default from: "megabbq@goodprogrammer.ru"

  # Задаем макет для всех писем
  layout 'mailer'
end
