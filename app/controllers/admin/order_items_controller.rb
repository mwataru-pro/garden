class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_item_params)

    if @order_item.making_status == "製作中"
      @order.update(order_status: 2)
    elsif @order.order_items.count ==  @order.order_items.where(making_status: 3).count
      @order.update(order_status: 3) #注文ステータスを「発送準備中]に更新
    end
    redirect_to admin_order_path(@order_item.order) #注文詳細に遷移
  end

  private
  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
