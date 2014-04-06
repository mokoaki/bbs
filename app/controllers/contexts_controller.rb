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
      #noŽæ‚ç‚ê‚Ä‚½‚ç‚P‘«‚µ‚ÄÄƒgƒ‰ƒC
      while context.id.nil?
        context.save rescue
        context.no += 1
      end
    end

    @bbs_thread_id = context.bbs_thread_id
    @contexts      = Context.where(bbs_thread_id: @bbs_thread_id).where("no >= ?", context_params['no'])
  end

  def recontexts
    search = ">>#{params[:no]}"

    temp_contexts = Context.where("bbs_thread_id = #{params[:bbs_thread_id]}").where("#{params[:no]} < no").where("description like ?", "%#{search}%")

    @contexts = []

    temp_contexts.each do |temp_context|
      if temp_context.description =~ /#{search}[^0-9]/
        @contexts << temp_context
      end
    end
  end

  private

  def context_params
    params.require(:context).permit(:bbs_thread_id, :description, :no)
  end
end
