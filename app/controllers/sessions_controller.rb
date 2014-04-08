class SessionsController < ApplicationController
   #ログイン
  def new
  end

  #ログインtry
  def create
    user = User.normal_select.find_by(email: params[:email].downcase, enable: true)

    if user && user.authenticate(params[:password])
      sign_in user

      redirect_to root_url
    else
      render 'new'
    end
  end

  #ログアウト
  def destroy
    sign_out
    redirect_to root_url
  end
end
