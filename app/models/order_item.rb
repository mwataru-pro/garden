class OrderItem < ApplicationRecord
  # アソシエーション
  belongs_to :order
  belongs_to :item

  # enumの設定
  enum making_status: [:着手不可, :制作待ち, :製作中, :制作完了]
end
