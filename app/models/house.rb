class House < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :house_category
  belongs_to_active_hash :room_type
  belongs_to_active_hash :prefecture
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_one :address
  # validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'Out of setting range' }
end

