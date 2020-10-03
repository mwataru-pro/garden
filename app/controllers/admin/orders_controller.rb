class Admin::OrdersController < ApplicationController
  def index
    # 遷移元ごとに表示内容を変更するためifで条件分岐
    @path = Rails.application.routes.recognize_path(request.referer) # 遷移元のcontrollerやaction名を取得する
    if @path[:controller] == "admin/customers" && @path[:action] == "show" # 遷移元がcustomersコントローラでshowアクションだったら
      @orders = Order.where(customer_id: params[:format]).page(params[:page]).per(5) # 該当会員のOrderデータのみを取得
    elsif @path[:controller] == "admins/homes" # 遷移元がhomesコントローラからだったら
      @orders = Order.where(created_at: Time.zone.today.all_day).page(params[:page]).per(5) #本日の注文されたもののみ取得
    else
      @orders = Order.page(params[:page]).per(5) #それ以外のアクセス。ヘッダーから。
    end
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
