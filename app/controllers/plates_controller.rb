class PlatesController < ApplicationController
  before_action :no_login_user_goto_root

  def show
    @plate = current_user.plates.find_by(id: params[:id])

    if @plate.nil?
      redirect_to root_path
      return
    end

    @bbs_threads = @plate.bbs_threads
  end

  def create
    #super_admin?

    @plate = Plate.create(plate_params)
  end


  private

  def plate_params
    params.require(:plate).permit(:name)
  end
end
