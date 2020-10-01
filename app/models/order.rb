class Order < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  has_many :oreder_items

  # enumの設定
  enum payment_method: {銀行振込: 0, クレジットカード: 1}
  enum order_status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済: 4}

  # バリデーション
  validates :address, presence: true, length: {minimum: 2, maximum: 50}
  validates :postal_code, presence: true, length: {minimum: 2, maximum: 7}
  validates :name, presence: true, length: {minimum: 2, maximum: 35}
end
