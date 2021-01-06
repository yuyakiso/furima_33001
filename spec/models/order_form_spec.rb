require 'rails_helper'

describe OrderForm do
  before do 
    @order_form = FactoryBot.build(:order_form)
  end

  describe '住所情報登録' do
    context '住所情報登録が上手くいく時' do
      it "postal_code, prefecture_id, city, address, phone_number,tokenが存在すれば登録できる" do
        expect(@order_form).to be_valid
      end
    end

    context '住所情報登録が上手くいかない時' do
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

      it 'tokenが空だと登録できない' do
        @order_form.token = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end

