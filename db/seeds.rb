# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者アカウントの作成
Admin.create!(
  email: "admin@admin.com",
  password: "admins",
  password_confirmation: "admins"
  )

# 会員アカウントの作成
9.times do |n|
Customer.create!(
  email: "member#{n+1}@member",
  last_name: "太朗#{n+1}",
  first_name: "山田#{n+1}",
  last_name_kana: "タロウ#{n+1}",
  first_name_kana: "ヤマダ#{n+1}",
  postal_code: "1234567",
  address: "東京都渋谷区神宮前三丁目",
  phone_number: "00012345678",
  password: "members",
  password_confirmation: "members"
  )
end

# ジャンル
Genre.create!(
[
  {
    name: "大鉢",
    valid_invalid_status: 0
  },
  {
    name: "中鉢",
    valid_invalid_status: 0
  },
  {
    name: "小鉢",
    valid_invalid_status: 0
  },
  {
    name: "外鉢",
    valid_invalid_status: 0
  },
  {
    name: "備品",
    valid_invalid_status: 0
  }
]
)

# 商品
Item.create!(
[
  {
    genre_id: 1,
    item_name: "ストレリチア",
    explanation: "扇のように広がる大きい葉が特徴で、花が咲いた様子は極楽鳥花と呼ばれるものです。",
    price: 30000,
    sale_status: 0,
  },
  {
    genre_id: 3,
    item_name: "ポトス",
    explanation: "ツタのように垂れ下がり伸びていきます。育てやすく初心者の方にもおすすめです。",
    price: 3000,
    sale_status: 0,
  },
  {
    genre_id: 3,
    item_name: "ガジュマル",
    explanation: "多幸の木と呼ばれ、沖縄では精霊キジムナーが宿るとも言われる植物です。日光の少ないところでも育てられる丈夫な植物です。",
    price: 8000,
    sale_status: 0,
  },
  {
    genre_id: 3,
    item_name: "フィロデンドロン・シルバーメタル",
    explanation: "ポトスのように、幹を持たない蔓性の植物です。その名の通りシルバーがかった色合いが魅力的で、育てやすさもある植物です。色味の違う植物をお探しの方におすすめです。",
    price: 3000,
    sale_status: 0,
  },
  {
    genre_id: 2,
    item_name: "パキラ",
    explanation: "発財の木とも呼ばれ、縁起物として贈答品に選ばれることも多い植物です。乾燥に強く、水やりも週に一度程度で管理もしやすくおすすめです。",
    price: 10000,
    sale_status: 0,
  },
  {
    genre_id: 2,
    item_name: "フィカス・ウンベラータ",
    explanation: "薄く丸い大きい葉が特徴で、ゴム科の植物です。インテリア雑誌などでもよく扱われていてフィカスの中では定番の一種です。購入希望者が多い人気の一品になります。",
    price: 13000,
    sale_status: 0,
  },
  {
    genre_id: 1,
    item_name: "フィカス・ベンガレンシス",
    explanation: "マットな質感で大きい葉が特徴のゴム科の植物です。光沢のあるアルテシマ、薄くて丸い葉のウンベラータ、マットな質感で落ち着いた印象のベンガレンシス。フィカスの三代巨塔と呼べそうです。",
    price: 30000,
    sale_status: 0,
  },
  {
    genre_id: 4,
    item_name: "オリーブ・ネバディロブランコ",
    explanation: "違う種類のオリーブを置くと、実がなります。外鉢の植物は風通しや日当たりが室内環境と異なりますので、水やりは週に２〜３回そこから出るくらいたっぷりとあげてください。",
    price: 50000,
    sale_status: 0,
  },
]
)

# 配送先
Address.create!(
  [
    {
     name: "山田 太朗1",
     customer_id: 1,
     shipping_address: "東京都新宿区東新宿5丁目",
     postal_code: "1234567",
},
{
     name: "山田 太朗2",
     customer_id: 2,
     shipping_address: "東京都新宿区東新宿9丁目",
     postal_code: "1234567",
}
]
)

#注文
9.times do |n|
Order.create!(
[
  {
    customer_id: "#{n+1}",
    postage: 800,
    payment_method: 0,
    address: "神奈川県横浜市中区山手町37",
    postal_code: "2318651",
    name: "山田花子",
    total_fee: 33880,
    order_status: 0,
  },
]
)
end

# 注文履歴
OrderItem.create!(
[
  {
    order_id: 1,
    item_id: 1,
    order_price: 33000,
    quantity: 1,
    making_status: 0,
  },
  {
    order_id: 1,
    item_id: 2,
    order_price: 6600,
    quantity: 2,
    making_status: 0,
  },
  {
    order_id: 1,
    item_id: 5,
    order_price: 11000,
    quantity: 1,
    making_status: 0,
  },
  {
    order_id: 2,
    item_id: 1,
    order_price: 33000,
    quantity: 1,
    making_status: 0,
  },
  {
    order_id: 2,
    item_id: 2,
    order_price: 6600,
    quantity: 2,
    making_status: 0,
  },
  {
    order_id: 2,
    item_id: 5,
    order_price: 11000,
    quantity: 1,
    making_status: 0,
  }
]
)