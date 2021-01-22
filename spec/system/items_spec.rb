require 'rails_helper'

RSpec.describe "商品出品機能", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @users = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  context '投稿に失敗した時' do
    it '送る値が全て空だと出品に失敗する' do
      sign_in(@item.user)

      find(".purchase-btn").click

      expect {
        find(".sell-btn").click
      }.not_to change { Item.count }
      expect(current_path).to eq "/items"
    end
  end

  context '投稿に成功した時' do
    it '出品に成功すると、一覧表示に投稿した内容が表示されている' do
      sign_in(@item.user)

      find(".purchase-btn").click

      attach_file 'item-image', Rails.root.join('public/apple-touch-icon.png')
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.message
      select @item.category.name, from: 'item-category'
      select @item.status.name, from: 'item-sales-status'
      select @item.charge.name, from: 'item-shipping-fee-status'
      select @item.prefecture.name, from: 'item-prefecture'
      select @item.schedule.name, from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @item.price

      expect {
        find(".sell-btn").click
      }.to change { Item.count }.by(1)

      expect(current_path).to eq root_path

      expect(page).to have_content(@item.name)
    end
  end
end

RSpec.describe "商品編集機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  context '商品の編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の編集ができる' do
      sign_in(@item1.user)

      visit item_path(@item1.id)

      find(".item-red-btn").click

      expect{
      find(".sell-btn").click
      }.to change { Item.count }.by(0)

      expect(current_path).to eq item_path(@item1.id)
    end
  end

  context '商品の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      sign_in(@item1.user)

      visit item_path(@item2.id)

      expect(page).to have_no_content '商品の編集'
    end

    it 'ログインしていないと商品情報の編集画面には遷移できない' do
      visit root_path

      visit item_path(@item1.id)

      expect(page). to have_no_content '商品の編集'
    end
    
  end
end

RSpec.describe "商品削除機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  context '商品の削除ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の削除ができる' do
      sign_in(@item1.user)

      visit item_path(@item1.id)

      find(".item-destroy").click

      expect(current_path).to eq root_path
    end
  end

  context '商品の削除ができないとき' do
    it 'ログインしたユーザーは自分が出品した商品以外の削除はできない' do
      sign_in(@item1.user)

      visit item_path(@item2.id)

      expect(page). to have_no_content '削除'
    end

    it 'ログインしていないと商品情報の削除はできない' do
      visit root_path

      visit item_path(@item1.id)

      expect(page). to have_no_content '削除'
    end
  end
end
