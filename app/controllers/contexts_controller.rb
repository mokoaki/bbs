class ContextsController < ApplicationController
  before_action :no_login_user_goto_signin_path
  before_action :no_admin_user_goto_root, only: [:destroy]

  def show
    @context = get_context_by_context_id(params[:id])

    if @context.nil?
      redirect_to root_path
      return
    end

    @bbs_thread = @context.bbs_thread
    @plate      = @bbs_thread.plate
  end

  def create
    @bbs_thread = get_bbs_thread_by_id(context_params['bbs_thread_id'])

    context           = Context.new(context_params)
    context.user_id   = current_user.id
    context.user_name = current_user.name
    context.no        = @bbs_thread.contexts_count + 1 #上書き

    if context.valid?
      #no取られてたら１足して再トライ
      while context.id.nil?
        context.save rescue
        context.no += 1
      end
    end

    @contexts = Context.where(bbs_thread_id: @bbs_thread.id).where("no >= ?", context_params['no']).order(:id)

    @bbs_thread.contexts_count = context.no
    @bbs_thread.save
  end

  def recontexts
    search = ">>#{params[:no]}"

    temp_contexts = Context.where("bbs_thread_id = #{params[:bbs_thread_id]}").where("#{params[:no]} < no").where("description like ?", "%#{search}%").order(id: :desc)

    @contexts = []

    temp_contexts.each do |temp_context|
      if temp_context.description =~ /#{search}([^0-9]|\z)/
        @contexts << temp_context
      end
    end
  end

  def destroy
    context = get_context_by_context_id(params[:id])

    if context.nil?
      raise 'どっかーん'
    end

    @deleted_context_id = context.id

    context.delete_flg = true
    context.save
  end

  private

  def context_params
    params.require(:context).permit(:plate_id, :bbs_thread_id, :description, :no)
  end
end
