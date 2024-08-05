class Api::SheetsController < ApplicationController
  def index
    @sheets = Sheet.where(workspace_id: params[:workspace_id])
    render json: @sheets
  end

  def create
    @sheet = Sheet.new(sheet_params)
    if @sheet.save
      render json: @sheet
    else
      render json: @sheet.errors, status: :unprocessable_entity
    end
  end

  def show
    @sheet = Sheet.find(params[:id])
    render json: @sheet
  end

  def update
    @sheet = Sheet.find(params[:id])
    if @sheet.update(sheet_params)
      render json: { notice: '編集内容を保存しました' }, status: :ok
    else
      render json: { errors: @sheet.errors.full_messages, alert: '保存に失敗しました' }, status: :unprocessable_entity
    end
  end

  def destroy
    @sheet = Sheet.find(params[:id])
    if @sheet.destroy
      render json: { notice: '表を削除しました' }, status: :ok
    else
      render json: @sheet.errors, status: :unprocessable_entity
    end
  end

  private

  def sheet_params
    params.require(:sheet).permit(:name, :explanation, :workspace_id)
  end
end
