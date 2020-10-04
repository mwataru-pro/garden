class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.save
    redirect_to public_customer_path(@customer)
  end

  def withdrawal
  end

  def destroy
    #is_deletedカラムにフラグを立てる(defaultはfalse)
    current_member.update(is_deleted: true, whithdrawal_status: 1)
    #ログアウトさせる
    reset_session
    redirect_to root_path
  end

  private
  def member_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :whithdrawal_status, :email)
  end
end
