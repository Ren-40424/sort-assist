class Api::WorkspacesController < ApplicationController
  def index
    @workspaces = Workspace.includes([:workspace_users, :users]).where(workspace_users: { user_id: current_user.id })
    if @workspaces
      json_data = @workspaces.map do |workspace|
        {
          id: workspace.id,
          name: workspace.name,
          explanation: workspace.explanation,
          users: workspace.users.as_json(except: [:email, :created_at, :updated_at])
        }
      end
      render json: json_data
    else
      render json: { error: 'ワークスペースが見つかりませんでした' }, status: :not_found
    end
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

  def update
    @workspace = Workspace.find(params[:id])
    if @workspace.update(workspace_params)
      render json: { workspace: @workspace, notice: '編集内容を保存しました' }, status: :ok
    else
      render json: { errors: @workspace.errors.full_messages, alert: '保存に失敗しました' }, status: :unprocessable_entity
    end
  end

  def destroy
    @workspace = Workspace.find(params[:id])
    if @workspace.destroy
      render json: { workspace: @workspace, notice: 'ワークスペースを削除しました' }, status: :ok
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  def add_user
    added_users = []
    workspace_user_params.each do |workspace_user_param|
      workspace_user = WorkspaceUser.create!(workspace_user_param)

      added_users << { user: workspace_user.user.as_json(except: [:email, :created_at, :updated_at]),
                       role: Role.find(workspace_user[:role_id]) }
    end
    render json: { users: added_users, message: 'ユーザーを追加しました' }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :explanation)
  end

  def workspace_user_params
    params.require(:workspace_users).map do |workspace_user_param|
      workspace_user_param.permit(:workspace_id, :user_id, :role_id)
    end
  end
end
