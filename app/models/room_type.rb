class RoomType < ActiveHash::Base
  self.data = [
    { id: 1, name: '--'},
    { id: 2, name: '一軒家'},
    { id: 3, name: 'タウンハウス（町家・長屋）' },
    { id: 4, name: 'ペンション' },
    { id: 5, name: 'ログハウス' },
    { id: 6, name: 'ドームハウス' },
    { id: 7, name: 'コテージ' },
    { id: 8, name: 'バンガロー' },
    { id: 9, name: '古民家' },
    { id: 10, name: 'マンション&アパート' },
    { id: 11, name: 'コンドミニアム' },
    { id: 12, name: 'サービスアパートメント' },
    { id: 13, name: 'ロフト' },
    { id: 14, name: 'デザイナーズホテル' },
    { id: 15, name: 'ロッジ' },
    { id: 16, name: 'ゲストハウス' },
    { id: 17, name: 'アパートホテル' },
    { id: 18, name: 'リゾートホテル・別荘' }
  ]
  include ActiveHash::Associations
  has_many :houses
end
