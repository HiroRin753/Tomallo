class HouseCategory < ActiveHash::Base
  self.data = [
    { id:1, name: '--'},
    { id:2, name: '戸建'},
    { id: 3, name: 'マンション・アパート' },
    { id: 4, name: 'ホテル' }
  ]

  include ActiveHash::Associations
  has_many :houses
end
