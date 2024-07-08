class Api::UsersController < ApplicationController
  def index
    @workspace_users = WorkspaceUser.where(workspace_id: params[:workspace_id]).includes(:user)
    render json: @workspace_users.as_json(include: :user)
  end
end
