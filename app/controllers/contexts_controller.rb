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
    context.no      = Context.where(bbs_thread_id: params[:context][:bbs_thread_id]).size + 1

    if context.valid?
      while context.id.nil?
        context.save rescue
        context.no += 1
      end
    end

    @bbs_thread_id = context.bbs_thread_id
    @contexts      = Context.where(bbs_thread_id: @bbs_thread_id).where("no >= ?", context_params['no'])
  end

  def recontexts
    @contexts = Context.where("bbs_thread_id = #{params[:bbs_thread_id]}").where("no > #{params[:no]}").where("description like ?", "%>>#{params[:no]} %")

    @contexts.each do |context|
      logger.info(params[:margin])
      logger.info(context.inspect)
    end
  end

  private

  def context_params
    params.require(:context).permit(:bbs_thread_id, :description, :no)
  end
end
