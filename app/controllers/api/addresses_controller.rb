class Api::AddressesController < ApplicationController
  def index
    @addresses = Address.where(sheet_id: params[:sheet_id])
    render json: @addresses
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      render json: @address
    else
      render json: @address.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      head :no_content
    else
      render status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(:district, :address_from, :address_to, :name, :explanation, :load_place, :sheet_id, :course_id)
  end
end
