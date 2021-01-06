class BuyLog < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :customer_adress
end
