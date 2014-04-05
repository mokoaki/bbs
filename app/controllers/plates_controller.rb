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

  def index
    if current_user.super_admin?
      @plates = Plate.where(nil)
    else
      @plates = curren_user.plates
    end

    @plate = Plate.new
  end

  def create
    @plate = Plate.create(plate_params)
    redirect_to plates_path
  end


  private

  def plate_params
    params.require(:plate).permit(:name)
  end
end
