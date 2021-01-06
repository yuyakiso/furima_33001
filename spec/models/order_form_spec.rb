require 'rails_helper'

describe OrderForm do
  before do 
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form,item_id: item.id,user_id: user.id)
  end

  describe '購入手続き' do
    context '購入手続き' do
      it "postal_code, prefecture_id, city, address, phone_number, token, user_id, item_idが存在すれば登録できる" do
        expect(@order_form).to be_valid
      end

      it "buildが空でも登録できる" do
        @order_form.build = ""
        expect(@order_form).to be_valid
      end

    end

    context '購入手続きが上手くいかない時' do
      it 'postal_codeが空だと登録できない' do
        @order_form.postal_code = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフン(-)がないと登録できない' do
        @order_form.postal_code = 0000000
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code is invalid")
      end

      it 'prefecture_idが空だと登録できない' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが０だと登録できない' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture must be other than 0")
      end

      it 'cityが空だと登録できない' do
        @order_form.city = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと登録できない' do
        @order_form.address = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと登録できない' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberにハイフン(-)があると登録できない' do
        @order_form.phone_number = 00000000000
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが12桁以上だと登録できない' do
        @order_form.phone_number = 000000000000
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが英数混合だと登録できない' do
        @order_form.phone_number = "test0000000"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end


      it 'tokenが空だと登録できない' do
        @order_form.token = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと登録できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと登録できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

