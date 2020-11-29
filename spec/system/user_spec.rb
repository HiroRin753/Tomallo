require 'rails_helper'

RSpec.describe 'User', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'snsでサインアップができるとき' do
    it 'ユーザーが増えること' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'Nickname', with: @user.nickname 
      fill_in 'Last name', with: @user.last_name
      fill_in 'First name', with: @user.first_name
      fill_in 'Last name kana', with: @user.last_name_kana
      fill_in 'First name kana', with: @user.first_name_kana
      

      expect{
        click_link 'Googleで登録'
        sleep 1
      }.to change(User, :count).by(1)
    end
  end

  context 'サインアップ済みの場合' do
    before do
      User.create!(
      email: 'test@example.com',
      password: 'test12'
      )
    end

    it 'ユーザーは増えないこと' do
      visit root_path
      expect{
        click_link 'Googleで登録'
        sleep 1
      }.to_not change(User, :count)
    end
  end
end
