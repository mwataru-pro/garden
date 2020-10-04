class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_address, only:[:edit, :update, :destroy]

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to public_addresses_path
  end

  def edit
  end

  def update
    @address.update(address_params)
    redirect_to public_addresses_path
  end

  def destroy
    @address.destroy
    redirect_to public_addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:name, :member_id, :shipping_address, :postal_code)
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
