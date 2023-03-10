class SubscriptionsController < ApplicationController
  # Задаем event для подписки
  before_action :set_event, only: %i[create destroy]

  # Задаем подписку, которую юзер хочет удалить
  before_action :set_subscription, only: %i[destroy]

  def create
    # Болванка для новой подписки
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      # Отправляем письмо автору события о подписке
      EventMailer.subscription(@event, @new_subscription).deliver_now

      # Перерисовываем окно мероприятия
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      # Перерисовываем форму ввода с указанием ошибок валидации
      render 'events/show'
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.subscriptions.destroyed')}

    if current_user_can_edit?(@subscription)
      # Отправляем письмо автору события об отписке
      EventMailer.subscription_destroy(@event, @subscription).deliver_now

      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscriptions.error')}
    end

    redirect_to @event, message
  end

  private
  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    # .fetch разрешает в params отсутствие ключа :subscription
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
