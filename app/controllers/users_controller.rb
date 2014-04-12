class UsersController < ApplicationController
  before_action :no_login_user_goto_signin_path

  def index
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      flash.now[:success] = "更新おｋ"
    end

    render 'edit'
  end

  def search
    page = params[:page].to_i
    per_page = 20
    search = []

    params[:search].each do |key, value|
      value.strip!
      search << "#{key} like '%#{value}%'" if value.present?
    end

    @users = User.select(:id, :name, :email).where(search.join(' and ')).offset((page - 1) * per_page).limit(per_page)

    #adminの場合、[自分が権限を持っている板]に所属しているユーザのみ管理できる　未実装

    #if !super_admin?
    #  plate_ids = UserPlate.where(user_id: current_user.id).pluck(:id)
    #  @users.where(plate_id: plate_ids)
    #end
  end

  def plate_access
    if params[:access] == 'ok'
      UserPlate.delete_all(plate_id: params[:plate_id], user_id: params[:user_id])
    else
      UserPlate.create(plate_id: params[:plate_id], user_id: params[:user_id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:name ,:email, :password, :password_confirmation)
  end
end
