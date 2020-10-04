class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total = 0
    @items = Item.where(sale_status: 0).page(params[:page]).per(8)
  end

  def create
    if current_customer.cart_items.count >= 1 #カート内に商品があるか？
      if nil != current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #カートに入れた商品はすでにカートに追加済か？
          @cart_item_now = current_member.cart_items.find_by(item_id: params[:cart_item][:item_id]) #カート内のすでにある商品の情報取得
          @cart_item_now.quantity += params[:cart_item][:quantity].to_i # 既にある情報に個数を合算
          @cart_item_now.update(quantity: @cart_item_u.quantity) # 情報の更新　個数カラムのみ
          redirect_to public_cart_items_path
      else
          @cart_item = CartItem.new(cart_item_params) #新しくカートの作成
          @cart_item.customer_id = current_customer.id #誰のカートか紐付け
        if @cart_item.save
           redirect_to public_cart_items_path
        else
          @items = Item.where(sale_status: 0).page(params[:page]).per(8)
          @quantity = Item.count
          @genres = Genre.where(valid_invalid_status: 0)
          render 'index'
        end
      end
    else
      @cart_item = CartItem.new(cart_item_params) # 新規カートの作成(これより下は普通のcreate処理)
      @cart_item.customer_id = current_customer.id # 現ユーザーのカートとして紐付け
      if @cart_item.save
         redirect_to public_cart_items_path
      else
        @items = Item.where(sale_status: 0).page(params[:page]).per(8) # 販売ステータスが「0」のものを見つける
        @quantity = Item.count
        @genres = Genre.where(valid_invalid_status: 0)
        render 'public/items/index' # itemsコントローラのindexアクションまで飛ばす
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private

  def cart_item_item?
    redirect_to public_item_path(params[:cart_item][:item_id]), notice: "個数を入力してください。" if params[:cart_item][:quantity].empty?
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity,:customer_id)
  end
end
