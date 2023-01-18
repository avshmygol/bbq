class ApplicationMailer < ActionMailer::Base
  # обратный адрес всех писем по умолчанию
  default from: ENV["MAILJET_SENDER"]

  # Задаем макет для всех писем
  layout 'mailer'
end
