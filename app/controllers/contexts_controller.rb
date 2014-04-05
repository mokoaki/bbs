class ContextsController < ApplicationController
  before_action :no_login_user_goto_root

  def show
    @context = Context.find_by(id: params[:id])

    if @context.nil?
      redirect_to root_path
    end

    @bbs_thread = @context.bbs_thread
    @plate      = @bbs_thread.plate
  end

  def create
    context         = Context.new(context_params)
    context.user_id = current_user.id

    if context.valid?
      while context.id.nil?
        context.save rescue
        context.no += 1
      end
    end

    @bbs_thread_id = context.bbs_thread_id
    @contexts      = Context.where(bbs_thread_id: @bbs_thread_id).where("no >= ?", context_params['no'])
  end

  private

  def context_params
    params.require(:context).permit(:bbs_thread_id, :description, :no)
  end
end
