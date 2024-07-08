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
  end

  private
  
  def sheet_params
    params.require(:sheet).permit(:name, :explanation, :workspace_id)
  end
end