class UsersController < ApplicationController
  def show
  end

  def search
    if params[:query].present?
      # すでに追加済のユーザーは検索結果から省く
      already_added_user_ids = WorkspaceUser.where(workspace_id: params[:workspace_id]).select(:user_id)
      @users = User.where('name LIKE ?', "%#{params[:query]}%").where.not(id: already_added_user_ids) 
    else
      @users = User.all
    end
    
    render json: @users
  end
end
