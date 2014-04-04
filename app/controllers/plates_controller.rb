class PlatesController < ApplicationController
  before_action :no_login_user_goto_root

  def show
    @plate = current_user.plates.find_by(id: params[:id])

    if @plate.nil?
      redirect_to users_path
      return
    end

    @bbs_threads = @plate.bbs_threads
  end
end
