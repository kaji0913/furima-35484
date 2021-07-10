require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:seller)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる場合' do
      it 'name、email、passwordとpassword_confirmation、last_name、first_name、last_name_reading、first_name_reading、birthdayが存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上の半角英数字混合で、password_confirmationと一致していれば登録できること' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa111'
        expect(@user).to be_valid
      end

      it 'last_nameが全角であれば登録できること' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end

      it 'first_nameが全角であれば登録できること' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end

      it 'last_name_readingが全角カタカナであれば登録できること' do
        @user.last_name_reading = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'first_name_readingが全角カタカナであれば登録できること' do
        @user.first_name_reading = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない場合' do
      it 'nameが空では登録できないこと' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:seller, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていない場合、登録できないこと' do
        @user.email = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは数字のみでは登録できないこと' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordは英語のみでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordは全角文字では登録できないこと' do
        @user.password = 'ａａａ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa1111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが英語では登録できないこと' do
        @user.last_name = 'Ｙａｍａｄａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'last_nameが半角では登録できないこと' do
        @user.last_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが英語では登録できないこと' do
        @user.first_name = 'Ｔａｒｏ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'first_nameが半角では登録できないこと' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'last_name_readingが空では登録できないこと' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank")
      end

      it 'last_name_readingが英語では登録できないこと' do
        @user.last_name_reading = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid')
      end

      it 'last_name_readingが数字では登録できないこと' do
        @user.last_name_reading = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid')
      end

      it 'last_name_readingがひらがなでは登録できないこと' do
        @user.last_name_reading = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid')
      end

      it 'last_name_readingが漢字では登録できないこと' do
        @user.last_name_reading = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid')
      end

      it 'last_name_readingが半角カナでは登録できないこと' do
        @user.last_name_reading = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid')
      end

      it 'first_name_readingが空では登録できないこと' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end

      it 'first_name_readingが英語では登録できないこと' do
        @user.first_name_reading = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid')
      end

      it 'first_name_readingが数字では登録できないこと' do
        @user.first_name_reading = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid')
      end

      it 'first_name_readingがひらがなでは登録できないこと' do
        @user.first_name_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid')
      end

      it 'first_name_readingが漢字では登録できないこと' do
        @user.first_name_reading = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid')
      end

      it 'first_name_readingが半角カナでは登録できないこと' do
        @user.first_name_reading = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid')
      end

      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
