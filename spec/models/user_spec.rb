require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録が上手く行くとき' do
      it "nickname, email, password, password_confirmation, family_name, first_name, family_name_kana, first_name_kana, birth_dayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "family_name_kanaは全角カタカナ入力で登録ができる" do
        @user.family_name_kana = "カタカナ"
        expect(@user).to be_valid
      end
      it "first_name_kanaは全角カタカナ入力で登録できる" do
        @user.first_name_kana = "カタカナ"
        expect(@user).to be_valid
      end
    end

    context '新規登録が上手くいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在するとき登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空だと登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが５文字以下だと登録できない' do
        @user.password = "aaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordは全角では登録できない' do
        @user.password = "テスト１２３４"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordは半角英語のみでは登録できない' do
        @user.password = "testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが存在してもpassword_confirmationが存在しなしと登録できない' do
        @user.password = "test1234"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = "test1234"
        @user.password_confirmation = "test0000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'family_nameが空だと登録できない' do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid")
      end
      it 'first_nameが空だと登録できない'do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it 'family_nameは半角が含まれると登録できない' do
        @user.family_name = "ｱｲｳｴ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it 'first_nameは半角が含まれると登録できない' do
        @user.first_name = "ｱｲｳｴ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'family_name_kanaが空だと登録できない' do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana is invalid")
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end
      it 'family_nameが全角カタカナ入力出なければ登録できない' do
        @user.family_name_kana = "ひらがな"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end
      it 'first_nameが全角カタカナ入力出なければ登録できない' do
        @user.first_name_kana = "ひらがな"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it 'birth_dayが空だと登録できない' do
        @user.birth_day = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end