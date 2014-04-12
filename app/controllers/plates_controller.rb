class PlatesController < ApplicationController
  before_action :no_login_user_goto_signin_path
  before_action :no_super_admin_user_goto_root, only: [:create, :update, :destroy]

  def index
  end

  def show
    @plate = get_plate_by_id(params[:id])

    if @plate.nil?
      redirect_to root_path
      return
    end
  end

  def create
    Plate.create(plate_params)

    redirect_to :back
  end

  def update
    params[:plates].each do |plate|
      Plate.update(plate[:id], name: plate[:name])
    end

    redirect_to :back
  end

  def destroy
    Plate.destroy(params[:id])

    redirect_to :back
  end

  private

  def plate_params
    @plate_params ||= params.require(:plate).permit(:name)
  end

  def no_super_admin_user_goto_root
    redirect_to(signin_path) if !super_admin?
  end
end
