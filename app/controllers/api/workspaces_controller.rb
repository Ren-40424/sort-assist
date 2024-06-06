class Api::WorkspacesController < ApplicationController
  protect_from_forgery except: [:create]

  def index
    @workspaces = current_user.workspaces
    render json: @workspaces
  end

  def create
    @workspace = Workspace.new(workspace_params)
    if @workspace.save
      WorkspaceUser.create(workspace_id: @workspace.id, user_id: current_user.id, role_id: 1)
      render json: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  def show
    @workspace = Workspace.find(params[:id])
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :explanation)
  end

end