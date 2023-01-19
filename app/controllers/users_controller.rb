class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  def show; end

  def destroy
    begin
      @user.destroy

      redirect_to events_url, notice: I18n.t('controllers.users.destroyed')
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to edit_user_registration_path,
        alert: "Нельзя удалить учётную запись, имеются связанные мероприятия (#{@user.events.count} шт.)"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
