require 'rails_helper'

  describe User do
    before do
      @user = FactoryBot.build(:user)
    end
    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it "nicknameとemail、passwordとpassword_confirmation、name、birthdayが存在すれば登録できる" do
          expect(@user).to be_valid
        end
        it "passwordが6~12文字の半角英数混合であれば登録できる" do
          @user.password = "00000q"
          @user.password_confirmation = "00000q"
          expect(@user).to be_valid
        end
      end
  
      context '新規登録がうまくいかないとき' do
        it "nicknameが空だと登録できない" do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it "emailが空では登録できない" do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it "emailは@を含んでいないと登録できない" do
          @user.email = "eudiivi21992"
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end
        it "重複したemailが存在する場合登録できない" do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Email has already been taken")
        end
        it "パスワードが空では登録できない" do
          @user.password = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it "パスワードは半角英字のみでは登録できない" do
          @user.password = 'aaaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password  Include both letters and numbers")
        end
        it "パスワードは半角数字のみでは登録できない" do
          @user.password = '000000'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password  Include both letters and numbers")
        end
        it "パスワードとパスワード（確認用）、値の一致がしていないと登録できない" do
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it "名字が空では登録できない" do
          @user.last_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
        it "名前が空では登録できない" do
          @user.first_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end
        it "名字のカナが空では登録できない" do
          @user.last_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana はカタカナで入力して下さい。")
        end
        it "名前のカナが空では登録できない" do
          @user.first_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana はカタカナで入力して下さい。")
        end
        it "名字は、全角入力でないと登録できない" do 
          @user.last_name = "ｱｲｳｴｵ"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name is invalid")
        end
        it "名前は、全角入力でないと登録できない" do 
          @user.first_name = "ｱｲｳｴｵ"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name is invalid")
        end
        it "名字のカナは、全角カタカナでないと登録できない" do
          @user.last_name_kana = "あいうえお"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana はカタカナで入力して下さい。")
        end
        it "名前のカナは、全角カタカナでないと登録できない" do
          @user.first_name_kana = "あいうえお"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana はカタカナで入力して下さい。")
        end
        it "生年月日が空では登録できない" do
          @user.birthday = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end