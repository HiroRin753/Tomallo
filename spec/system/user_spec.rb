require 'rails_helper'

RSpec.describe 'User', type: :system do
  before do
    @user = FactoryBot.build(:user)
    OmniAuth.config.mock_auth[:facebook] = nil
    Rails.application.env_config['omniauth.auth'] = facebook_mock
  end

  context 'snsでサインアップができるとき' do
    it '正しい情報を入力すると登録できる' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      expect(page).to have_content('Facebookで登録')
      find_link('Facebookで登録', href: '/users/auth/facebook').click
      fill_in 'Last name', with: @user.last_name
      fill_in 'First name', with: @user.first_name
      fill_in 'Last name kana', with: @user.last_name_kana
      fill_in 'First name kana', with: @user.first_name_kana
      expect{ find('input[name="commit"]').click}.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'snsでサインアップできないとき'do 
   it '誤った情報では登録できない' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      expect(page).to have_content('Facebookで登録')
      find_link('Facebookで登録', href: '/users/auth/facebook').click
      fill_in 'Last name', with: ""
      fill_in 'First name', with: ""
      fill_in 'Last name kana', with: ""
      fill_in 'First name kana', with: ""
      expect{find('input[name="commit"]').click}.to change{User.count}.by(0)
   end
  end 

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      find_link('Facebookでログイン', href: '/users/auth/facebook').click
      expect(current_path).to eq root_path
      expect(page).to have_content('マイページ')
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end
