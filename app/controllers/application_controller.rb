class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method [:current_user, :signed_in?, :admin?, :super_admin?]
  helper_method [:get_plates, :get_plate_by_id, :get_bbs_thread_by_id, :get_bbs_threads_by_plate_id]

  private

  def get_plates
    return @plates if @plates

    if super_admin?
      @plates = Plate.where(nil)
    else
      @plates = current_user.plates
    end
  end

  def get_plate_by_id(plate_id)
    @get_plate_by_id ||= {}
    @get_plate_by_id[plate_id] ||= get_plates.find_by(id: plate_id)
  end

  def get_bbs_thread_by_id(bbs_thread_id)
    @get_bbs_thread_by_id ||= {}
    @get_bbs_thread_by_id[bbs_thread_id] ||= BbsThread.where(plate_id: get_plates.pluck(:id)).find_by(id: bbs_thread_id)
  end

  def get_bbs_threads_by_plate_id(plate_id)
    @get_bbs_threads_by_plate_id ||= {}
    @get_bbs_threads_by_plate_id[plate_id] ||= BbsThread.where(plate_id: plate_id).where(plate_id: get_plates.pluck(:id))
  end

  def auth_check_by_plate_id(plate_id)
    return true if super_admin?

    @auth_check_by_plate_id ||= {}
    @auth_check_by_plate_id[plate_id] ||= get_user_plates(current_user.id, plate_id)
  end

  def auth_check_by_bbs_thread_id(bbs_thread_id)
    return true if super_admin?

    @auth_check_by_bbs_thread_id ||= {}
    @auth_check_by_bbs_thread_id[bbs_thread_id] ||= get_user_plates(current_user.id, get_bbs_thread_by_id(bbs_thread_id).plate_id)
  end

  def get_user_plates(user_id, plate_id)
    @get_user_plates ||= {}
    @get_user_plates["#{user_id}_#{plate_id}"] ||= UserPlate.find_by(user_id: user_id, plate_id: plate_id)
  end

  def current_user
    @current_user ||= User.find_by(remember_token: User.encrypt(cookies[:remember_token]))
  end

  def super_admin?
    current_user.super_admin?
  end

  def admin?
    current_user.admin?
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
