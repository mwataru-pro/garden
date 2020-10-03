class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(7)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      if @order.order_status == "入金確認" # order_statusが入金確認に更新されたら
        @order_items.update_all(making_status: 1) # 制作待ちに変更する処理
        redirect_to admin_order_path(@order)
      end
    else
      render "show"
    end
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
