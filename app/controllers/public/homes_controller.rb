class Public::HomesController < ApplicationController
  def top
    @items = Item.order("RANDO()").limit(4)
  end
end
