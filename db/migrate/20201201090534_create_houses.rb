class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string    :title,             null:false
      t.text      :description,       null:false
      t.text      :location,          nul:false
      t.string    :checkout,          null:false
      t.string    :checkin,           null:false
      t.integer   :house_category_id, null:false
      t.integer   :room_type_id,      null:false
      t.integer   :price,             null:false
      t.string    :postal_code,    default: "",  null: false
      t.integer   :prefecture_id,                null: false
      t.string    :city,           default: "",  null: false
      t.string    :house_number,   default: "",  null: false
      t.string    :building_name,  default: ""
      t.references  :user,            foreign_key: true
      t.timestamps
    end
  end
end
