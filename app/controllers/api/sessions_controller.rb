class Api::SessionsController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def create
    @user = User.find_for_database_authentication(email: params[:email])
    return invalid_email unless @user

    if @user.valid_password?(params[:password])
      sign_in :user, @user
      render :create
    else
      invalid_password
    end
  end

  private
  def invalid_email
    warden.custom_failure!
    render json: { error: t('invaild_eamil') }
  end

  def invalid_password
    warden.custom_failure!
    render json: { error: t('invaild_password') }
  end
end
