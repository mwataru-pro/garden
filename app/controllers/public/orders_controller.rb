class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders
  end

  def show
  end

  def new
  end

  def confirm
  end

  def thanks
  end
end
