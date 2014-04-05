class UsersController < ApplicationController
  before_action :no_login_user_goto_root

  def index
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      flash.now[:success] = "更新した"
    end

    render 'edit'
  end

  private

  def user_params
    params.require(:user).permit(:name ,:email, :password, :password_confirmation)
  end
end
