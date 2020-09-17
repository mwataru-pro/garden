class Item < ApplicationRecord
  # アソシエーション
  has_many :cart_items
  has_many :order_items
  belongs_to :genre

  attachment :image

  # enumの設定
  enum sale_status: {販売中: 0, 販売停止: 1}

  # バリデーション
  validates :item_name, presence: true, length: {minimum: 2, maximum:25}
  validates :explanation, presence: true, length: {minimum: 2, maximum: 250}
  validates :price, presence: true
end
