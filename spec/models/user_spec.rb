require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
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
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
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

      it 'passwordは半角英数字混合でないと登録できないこと' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
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
      
      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameが半角では登録できないこと' do
        @user.last_name = 'fuga'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_nameが半角では登録できないこと' do
        @user.first_name = 'fuga'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'last_name_readingが空では登録できないこと' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank")
      end
      
      it 'first_name_readingが空では登録できないこと' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end

      it 'last_name_readingが全角カタカナ以外では登録できないこと' do
        @user.last_name_reading = 'fuga'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading is invalid")
      end
      
      it 'first_name_readingが全角カタカナ以外では登録できないこと' do
        @user.first_name_reading = 'fuga'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading is invalid")
      end

      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

    end
  end
end
