class Address < ApplicationRecord
  # アソシエーション
  belongs_to :customer

  # バリデーション
  validates :postal_code, presence: true, length: {minimum: 2, maximum: 7}
  validates :shipping_address, presence: true, length: {minimum: 2, maximum: 50}
  validates :name, presence: true, length: {minimum: 2, maximum: 35}

  # 配送先住所の結合
  def address_all
    self.postal_code + " " + self.shipping_address + " " + self.name
  end
end
