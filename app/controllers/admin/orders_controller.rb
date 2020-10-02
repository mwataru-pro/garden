class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(7)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
  end

  private
  def order_params
    prams.require(:order).permit(:order_status)
  end
end
