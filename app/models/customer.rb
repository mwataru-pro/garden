class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :cart_items
  has_many :addresses
  has_many :orders

  # enumの設定
  enum withdrawal_status: {有効: 0,無効: 1}

  # バリデーション
  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, presence: true
  validates :last_name, length: {minimum: 1, maximum: 20}
  validates :first_name, length: {minimum: 1, maximum: 20}
  validates :last_name_kana, length: {minimum: 1, maximum: 20}
  validates :first_name_kana, length: {minimum: 1, maximum: 20}
  validates :postal_code, length: {minimum: 7, maximum: 7}
  validates :address, length: {minimum: 3, maximum:50}
  validates :phone_number, length: {minimum: 3, maximum: 15}

  def full_name
    self.last_name + " " + self.first_name
  end
end
