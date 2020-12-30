class Item < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :message
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :schedule_id
    validates :prefecture_id
    validates :image
    validates :price, format: {with: /\A[-]?[0-9]+(\.[0-9]+)?\z/}, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :schedule_id
    validates :prefecture_id
  end
  
extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :charge
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :schedule
  belongs_to_active_hash :status
  belongs_to :user
  has_one_attached :image

end
