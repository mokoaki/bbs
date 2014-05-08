class BbsThreadsController < ApplicationController
  before_action :no_login_user_goto_signin_path
  before_action :no_admin_user_goto_root, only: [:create, :update, :destroy]

  def show
    @bbs_thread = get_bbs_thread_by_id(params[:id])

    if @bbs_thread.nil?
      redirect_to root_path
      return
    end

    @plate = @bbs_thread.plate
  end

  def create
    plate = get_plate_by_id(params[:bbs_thread][:plate_id])

    begin
      BbsThread.transaction do
        bbs_thread = plate.bbs_threads.create(name: params[:bbs_thread][:name], contexts_count: 1)

        context           = bbs_thread.contexts.build(context_params)
        context.plate_id  = bbs_thread.plate_id
        context.user_id   = current_user.id
        context.user_name = current_user.name
        context.no        = 1
        context.save!

        redirect_to bbs_thread
      end
    rescue ActiveRecord::RecordInvalid
      logger.info('未記入項目 ロールバック')
      redirect_to :back
      return
    end
  end

  def update
    #created_at更新しない
    BbsThread.record_timestamps = false

    params[:bbs_threads].each do |id, bbs_thread|
      #権限チェック
      if auth_check_by_bbs_thread_id(id)
        BbsThread.update(id, bbs_thread)
      end
    end

    redirect_to :back
  end

  def destroy
    #権限チェック
    if auth_check_by_bbs_thread_id(params[:id])
      BbsThread.destroy(params[:id])
    end

    redirect_to :back
  end

  private

  #def bbs_thread_params
  #  @bbs_thread_params ||= params.require(:bbs_thread).permit(:plate_id, :name)
  #end

  def context_params
    params.require(:context).permit(:description)
  end
end
