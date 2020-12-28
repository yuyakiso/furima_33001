require 'rails_helper'
describe Item do
  before do 
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload("/files/staff1.jpg")
  end

  describe '商品新規出品' do
    context '新規出品が上手く行くとき' do
      it "name, image, message, category_id, status_id, charge_id, schedule_id, prefecture_id, priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context '新規出品が上手くいかないとき' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空だと登録できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'messageが空だと出品できない' do
        @item.message = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Message can't be blank")
      end

      it 'category_idが０だと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end

      it 'status_idが０だと登録できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 0")
      end

      it 'charge_idが０だと登録できない' do
        @item.charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge must be other than 0")
      end

      it 'schedule_idが０だと登録できない' do
        @item.schedule_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Schedule must be other than 0")
      end

      it 'prefecture_idが０だと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end

      it 'priceが空だと登録できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300未満だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが9999999より大きいと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'priceが全角数字だと登録できない' do
        @item.price = "１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end

