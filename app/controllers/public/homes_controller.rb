class Public::HomesController < ApplicationController
  def top
    @items = Item.order("RANDOM()").limit(4)
  end
end
