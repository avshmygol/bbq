class EventsController < ApplicationController
  # Встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show, :index]

  # Задаем объект @event для экшена show
  before_action :set_event, only: [:show]

  # Задаем объект @event от текущего юзера для других действий
  before_action :set_current_user_event, only: [:edit, :update, :destroy]

  # protect_from_forgery except: :password_guard!

  before_action :password_guard!, only: [:show]

  def index
    @events = Event.all
  end

  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  # Убедитесь, что в secrets.yml задано значение для  secret_key_base
  #
  # production:
  #   secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  #
  # И оно работает (например на Хероку задана нужная переменная окружения)
  #
  # Тогда куки в рельсах 4 и старше по умолчанию шифруются и хранить там пинкод
  # для данной задачи достаточно безопасно.
  #
  # http://api.rubyonrails.org/classes/ActionDispatch/Session/CookieStore.html
  #

  def password_guard!
    return true if @event.pincode.blank?
    return true if signed_in? && current_user == @event.user

    # Юзер на чужом событии (или не за логином). Проверяем, правильно ли передан пинкод.
    # Если правильно, запоминаем в куках этого юзера этот пинкод для данного события.
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    # Проверяем — верный ли в куках пинкод, если нет — ругаемся и рендерим форму
    pincode = cookies.permanent["events_#{@event.id}_pincode"]
    unless @event.pincode_valid?(pincode)
      if params[:pincode].present?
        flash.now[:alert] = I18n.t('controllers.events.wrong_pincode')
      end
      render 'password_form'
    end
  end
end
