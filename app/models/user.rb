class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, format: { with: /\A[a-z0-9]+\z/i}
    validates :nickname
    validates :birth_day
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/} do
    validates :family_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/} do
    validates :family_name_kana
    validates :first_name_kana
  end

  has_many :items
  has_many :buy_logs
end
