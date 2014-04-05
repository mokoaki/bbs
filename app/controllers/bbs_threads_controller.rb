class BbsThreadsController < ApplicationController
  before_action :no_login_user_goto_root

  def show
    @bbs_thread = BbsThread.find_by(id: params[:id])

    if @bbs_thread.nil?
      redirect_to root_path
      return
    end

    if UserPlate.find_by(user_id: current_user.id, plate_id: @bbs_thread.plate_id).nil?
      redirect_to plate path(@bbs_thread.plate_id)
      return
    end

    @plate = @bbs_thread.plate
  end
end
