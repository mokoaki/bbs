class ContextsController < ApplicationController
  before_action :no_login_user_goto_root

  def show
  end

  def create
    context = Context.new(context_params)
    context.user_id = current_user.id
    context.save

    redirect_to bbs_thread_path(id: 1)
  end

  private

  def context_params
    params.require(:context).permit(:bbs_thread_id, :description)
  end
end
