class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  
  has_many :houses
  has_many :reservations
  has_many :payments
  has_many :comments
  has_many :sns_credentials

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64'11'
      user.nickname = 'ゲスト'
      user.last_name = '田中'
      user.last_name_kana ='タナカ'
      user.first_name = '太郎'
      user.first_name_kana = 'タロウ'
      user.birthday = '20200101'
    end
  end

  def self.from_omniauth(auth)
   sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
   user = User.where(email: auth.info.email).first_or_initialize(
    nickname: auth.info.name,
    email: auth.info.email
   )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
   if user.persisted?
    sns.user = user
    sns.save
   end
   { user: user, sns: sns }
  end

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,12}+\z/i, message:' Include both letters and numbers'}
      
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]/} do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'} do
      validates :first_name_kana
      validates :last_name_kana
    end
  end
end
