class UsersController < ApplicationController
  def show
  end

  def search
    if params[:query].present?
      already_added_users = WorkspaceUser.where(workspace_id: params[:workspace_id]).pluck(:user_id)
      @users = User.where('name LIKE ?', "%#{params[:query]}%").where.not(id: already_added_users) # すでに追加済のユーザーは検索結果から省く
    else
      @users = User.all
    end
    
    render json: @users
  end
end
