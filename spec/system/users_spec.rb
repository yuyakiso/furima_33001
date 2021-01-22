require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @users = FactoryBot.create(:user)
  end

  it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'nickname', with: @user.nickname
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    fill_in 'password-confirmation', with: @user.password_confirmation
    fill_in 'family_name', with: @user.family_name
    fill_in 'first_name', with: @user.first_name
    fill_in 'family_name_kana', with: @user.family_name_kana
    fill_in 'first_name_kana', with: @user.first_name_kana
    select '1930', from: 'user_birth_day_1i'
    select '1', from: 'user_birth_day_2i'
    select '19', from: 'user_birth_day_3i'
    # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { User.count }.by(1)
    # トップページへ遷移したことを確認する
    expect(current_path).to eq root_path
    # カーソルを合わせるとログアウトボタンが表示されることを確認する
    expect(
      find(".logout").hover
    ).to have_content('ログアウト')
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
  end

  it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'nickname', with: ""
    fill_in 'email', with: ""
    fill_in 'password', with: ""
    fill_in 'password-confirmation', with: ""
    fill_in 'family_name', with: ""
    fill_in 'first_name', with: ""
    fill_in 'family_name_kana', with: ""
    fill_in 'first_name_kana', with: ""
    select '--', from: 'user_birth_day_1i'
    select '--', from: 'user_birth_day_2i'
    select '--', from: 'user_birth_day_3i'
    # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { User.count }.by(0)
    # 新規登録ページへ戻されることを確認する
    expect(current_path).to eq "/users"
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @users.email
      fill_in 'password', with: @users.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
   
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end