class Public::ItemsController < ApplicationController
  before_action :set_genre, only:[:index, :show, :search]

  def index
    @items = Item.where(sale_status: 0).page(params[:page]).per(8)
    @quantity = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def search
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8)
    @quantity = Item.where(genre_id: params[:format]).count
    render 'index'
  end

  private
  def set_genre
    @genres = Genre.where(valid_invalid_status: 0)
  end
end
