class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method [:current_user, :signed_in?]

  private

  def current_user
    @current_user ||= User.find_by(remember_token: User.encrypt(cookies[:remember_token]))
  end

  def sign_in(user)
    remember_token = User.new_remember_token

    cookies.permanent[:remember_token] = remember_token

    user.update_attribute(:remember_token, User.encrypt(remember_token))

    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = nil

    cookies.delete(:remember_token)
  end

  def no_login_user_goto_root
    redirect_to(signin_path) if !signed_in?
  end
end
