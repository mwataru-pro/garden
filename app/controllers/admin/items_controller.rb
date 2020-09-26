class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render "new"
    end
  end

  def edit
  end

  def update

  end

  private

  def item_params
    params.require(:item).permit(:genre_id,:item_name,:explanation,:price,:sale_status,:image)
  end
end
