class HouseAddress
  include ActiveModel::Model
  attr_accessor :title, :description, :location, :checkin, :checkout, :house_category_id, :room_type_id, :price, :postal_code, :prefecture_id, :city, :house_number, :building_name, :images, :user_id

  
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
    def save
      house = House.create(title: title, description: description, location: location, images: images, checkin: checkin, checkout:checkout, house_category_id: house_category_id, room_type_id: room_type_id,  price: price, user_id: user_id)
      Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, house_id: house.id)
    end
end