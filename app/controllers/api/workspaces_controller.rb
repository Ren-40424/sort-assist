class Api::WorkspacesController < ApplicationController
  def index
    @workspaces = Workspace.includes(:workspace_users).where(workspace_users: { user_id: current_user.id })
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
    @sheets = Sheet.where(workspace_id: @workspace.id).order('updated_at DESC')
  end

  def add_user
    workspace_user_params.each do |workspace_user_param|
      WorkspaceUser.create!(workspace_user_param)
    end

    render json: { message: 'Workspace users created successfully' }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :explanation)
  end

  def workspace_user_params
    params.require(:workspace_user).map do |workspace_user_param|
      workspace_user_param.permit(:workspace_id, :user_id, :role_id)
    end
  end
end
