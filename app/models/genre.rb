class Genre < ApplicationRecord
  # アソシエーション
  has_many :items

  # enum設定
  enum valida_invalid_status: {有効: 0, 無効: 1}

  # バリデーション
  validates :name, presence: true
end
