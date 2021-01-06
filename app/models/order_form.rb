class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :build, :phone_number, :order_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
    validates :token
    validates :user_id
    validates :item_id
  end
  
  def save
    buy_log = BuyLog.create(user_id: user_id, item_id: item_id )
    CustomerAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, build: build, phone_number: phone_number, buy_log_id: buy_log.id)
  end
end