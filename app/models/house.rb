class House < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :house_category
  belongs_to_active_hash :room_type
  belongs_to_active_hash :prefecture
  
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_one :adress
  
  with_options presence: true do 
    validates :title
    validates :location
    validates :checkin
    validates :checkout
    validates :image
    validates :price, numericality: { only_integer: true, message: 'は半角数字のみで入力してください'}        
    validates :description

    with_options numericality: { other_than: 1 } do
       validates :house_category_id
       validates :room_type_id
    end
  end
  # validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'Out of setting range' }
end
