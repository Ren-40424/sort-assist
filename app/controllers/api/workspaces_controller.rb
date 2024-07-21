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
    render json: @workspace
  end

  def update
    @workspace = Workspace.find(params[:id])
    if @workspace.update(workspace_params)
      render json: { notice: '編集内容を保存しました' }, status: :ok
    else
      render json: { errors: @workspace.errors.full_messages, alert: '保存に失敗しました' }, status: :unprocessable_entity
    end
  end

  def destroy
    @workspace = Workspace.find(params[:id])
    if @workspace.destroy
      render json: { notice: 'ワークスペースを削除しました' }, status: :ok
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
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
