class UsersController < ApplicationController
  before_action :no_login_user_goto_root, except: [:new, :signin]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user

      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user && @user.update_attributes(user_params)
      flash.now[:success] = "更新した"
    end

    render 'edit'
  end

  def signin
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name ,:email, :password, :password_confirmation)
  end
end
