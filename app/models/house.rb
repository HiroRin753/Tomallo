class House < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :days_to_ship
  belongs_to_active_hash :ship_from
  
  
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_one :purchase
  has_one :adress
  
  with_options presence: true do 
    validates :name
    validates :image
    validates :price, numericality: { only_integer: true, message: 'は半角数字のみで入力してください'}        
    validates :description

    with_options numericality: { other_than: 1 } do
       validates :condition_id
       validates :category_id
       validates :shipping_cost_id
       validates :days_to_ship_id
       validates :ship_from_id
    end
  end
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'Out of setting range' }
end
