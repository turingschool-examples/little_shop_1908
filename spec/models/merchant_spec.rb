require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'methods' do
    before(:each) do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @chain = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @tire = @bike_shop.items.create!(name: 'Tire', description: 'This is a tire.', price: 30, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 2)
      @order = Order.create!(customer_name: 'Joe Schmo', customer_address: '123 Random Dr', customer_city: 'Denver', customer_state: 'CO', customer_zip: 80_128)
      @item_order = ItemOrder.create!(item_id: @chain.id, order_id: @order.id, price: 50.00, quantity: 1)
    end

    describe 'has_orders?' do
      it 'shows if merchants have items being ordered' do
        expect(@bike_shop.has_orders?).to eq(true)
      end
    end

    describe 'count_of_items' do
      it 'shows the count of merchants items' do
        expect(@bike_shop.count_of_items).to eq(2)
      end
    end

    describe 'average_price' do
      it 'shows the average price of items for the merchant' do
        expect(@bike_shop.average_price).to eq(40)
      end
    end

    describe 'distinct_cities' do
      it 'shows the distinct cities ordered from for the merchant' do
        expect(@bike_shop.distinct_cities.to_sentence).to eq('Denver')
      end
    end
  end
end
