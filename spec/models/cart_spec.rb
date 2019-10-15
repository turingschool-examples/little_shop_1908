require 'rails_helper'

describe Cart, type: :model do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
    @chain = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 3)
    @tire = @bike_shop.items.create!(name: 'Tire', description: 'This is a tire.', price: 30, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 2)
    @cart = Cart.new(@chain.id.to_s => 2, @tire.id.to_s => 1)
  end

  describe 'methods' do
    describe 'count' do
      it 'calculates total number of items in cart' do
        expect(@cart.count).to eq(3)
      end
    end

    describe 'all_items' do
      it 'shows all items in the cart' do
        expect(@cart.all_items).to eq([@chain, @tire])
      end
    end

    describe 'item_count' do
      it 'shows count of specific item in the cart' do
        expect(@cart.item_count(@chain.id)).to eq(2)
      end
    end

    describe 'subtotal' do
      it 'shows subtotal cost of items in the cart' do
        expect(@cart.subtotal(@chain.id)).to eq(100)
      end
    end

    describe 'grand_total' do
      it 'shows grand total of all items in the cart' do
        expect(@cart.grand_total).to eq(130)
      end
    end

    describe 'add_item' do
      it 'increases quantity of item in cart' do
        @cart.add_item(@chain.id.to_s)
        expect(@cart.contents).to eq(@chain.id.to_s => 3, @tire.id.to_s => 1)
      end
    end

    describe 'subtract_item' do
      it 'decreases quantity of item in cart' do
        @cart.subtract_item(@tire.id)
        expect(@cart.item_count(@tire.id)).to eq(1)
      end
    end

    describe 'inventory_limit?' do
      it 'items in cart cannot exceed inventory amount' do
        expect(@cart.inventory_limit?(@chain.id)).to eq(false)
        @cart.add_item(@chain.id.to_s)
        expect(@cart.inventory_limit?(@chain.id)).to eq(true)
      end
    end
  end
end
