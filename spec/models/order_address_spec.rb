require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @seller = FactoryBot.create(:seller)
    @buyer = FactoryBot.create(:buyer)
    @item = FactoryBot.build(:item)
    @item.save
    @order_address = FactoryBot.build(:order_address, user_id: @buyer.id, item_id: @item.id)
    sleep 0.1 
  end

  describe '商品購入機能' do

    context '商品が購入できる場合' do
      it '必要な情報が適切に入力されていれば購入できること' do
        expect(@order_address).to be_valid
      end
    end

    context '商品を購入できない場合' do

      it 'tokenが空欄では購入できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")  
      end

      it 'postal_codeが空欄では購入できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")  
      end

      it 'postal_codeの保存にはハイフンが必要であること' do
        @order_address.postal_code = 1111111
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")  
      end

      it 'prefecture_idが1では購入できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")  
      end

      it 'cityが空欄では購入できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空欄では購入できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")  
      end

      it 'phone_numberが空欄では購入できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")  
      end

      it 'phone_numberが12桁以上では購入できないこと' do
        @order_address.phone_number = 111111111111
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")  
      end

    end
  end
end
