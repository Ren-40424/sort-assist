class Api::AddressesController < ApplicationController
  def create
    @address = Address.new(address_params)
    if @address.save
      render json: @address
    else
      render json: @address.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(:district, :address_from, :address_to, :name, :explanation, :load_place, :sheet_id, :course_id)
  end
end
