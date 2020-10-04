class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :request_post?, only: [:confirm]
  before_action :order_new?, only: [:new]

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_item = @order.order_items
    @total = 0
  end

  def new
    @customer = current_customer
    @order = Order.new
    @address = Address.new
  end

  def confirm
    params[:order][:payment_method] = params[:order][:payment_method].to_i # payment_methodを数値に変換
    @order = Order.new(order_params)

    if params[:order][:address_number] == "1" # address_numberが　”1”　なら、自分の自分の情報を代入する
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    elsif  params[:order][:address_number] ==  "2" # address_numberが　”2”　で登録済の住所が選ばれたら
      @order.postal_code = Address.find(params[:order][:address]).postal_code # newページで選ばれた配送先住所idから特定して郵便番号の取得代入
      @order.address = Address.find(params[:order][:address]).shipping_address # newページで選ばれた配送先住所idから特定して住所の取得代入
      @order.name = Address.find(params[:order][:address]).name # newページで選ばれた配送先住所idから特定して宛名の取得代入

    elsif params[:order][:address_number] ==  "3" # address_numberが　”3”　で新しいお届け先が選ばれたら
      @address = Address.new() # 変数の初期化
      @address.shipping_address = params[:order][:shipping_address] # newページで新しいお届け先に入力した住所を取得代入
      @address.name = params[:order][:name] # 入力された宛名を取得代入
      @address.postal_code = params[:order][:postal_code] # 入力された郵便番号を取得代入
      @address.customer_id = current_customer.id # 入力された会員idを代入
      if @address.save
        @order.postal_code = @address.postal_code
        @order.name = @address.name
        @order.address = @address.shipping_address
      else
        render 'new'
      end
    end

    @cart_items = CartItem.where(customer_id: current_customer.id) # 自身のカートから買った商品情報を取得代入
    @total = 0 # 変数定義：合計金額を入力するための整数型変数
  end

  def create
    # 注文の確定、保存
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    # 以下、order_itemの保存処理
    current_customer.cart_items.each do |cart_item|
      @order_item = OrderItem.new
      @order_item.order_id = @order.id
      @order_item.item_id = cart_item.item_id
      @order_item.order_price = (cart_item.item.price * 1.1).floor
      @order_item.quantity = cart_item.quantity
      @order_item.save
    end
    # カートの中身を削除し空の状態に戻す
    current_customer.cart_items.destroy_all
    redirect_to public_orders_thanks_path
  end

  def thanks
  end

  private

  def order_new?
    redirect_to public_cart_items_path, notice: "カートに商品を入れてください。" if current_customer.cart_items.blank?
  end

  def request_post?
    redirect_to new_public_order_path, notice: "もう一度最初から入力してください。" unless request.post?
  end

  def order_params
    params.require(:order).permit(:payment_method, :address, :postage, :postal_code, :name, :total_fee)
  end

  def address_params
    params.permit(:shipping_address, :name, :postal_code, :member_id)
  end
end
