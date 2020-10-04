class Admin::CustomersController < ApplicationController
  before_action :set_customer, only:[:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :first_name_kana,:last_name_kana, :postal_code,:address, :phone_number, :whithdrawal_status)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
