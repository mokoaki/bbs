class SessionsController < ApplicationController
   #ログイン
  def new
  end

  #ログインtry
  def create
    user = User.find_by(email: params[:email].downcase, enable: true)

    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #ログアウト
  def destroy
    sign_out
    redirect_to root_url
  end
end
