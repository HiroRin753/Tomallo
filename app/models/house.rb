class House < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :house_category
  belongs_to_active_hash :room_type
  belongs_to_active_hash :prefecture
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_one :address
  
  with_options presence: true do
    validates :user_id
    validates :checkin
    validates :checkout
    validates :images
    validates :price,         numericality: { only_integer: true, message: 'は半角数字のみで入力してください' }
    validates :postal_code,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city,          format: { with: /\A[ぁ-んァ-ン一-龥]/ }

    with_options numericality: { other_than: 1 } do
      validates :prefecture_id
      validates :house_category_id
      validates :room_type_id
    end
    with_options format: { with: /\A[ぁ-んァ-ン一-龥0-9]/ } do
      validates :title
      validates :location
      validates :description
      validates :house_number
    end
  end
end

