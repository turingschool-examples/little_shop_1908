require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  describe "merchant methods" do
    before :each do
      @scott = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @FFX_game = @scott.items.create!(name: 'FFX', description: "FFX For PS4", price: 20, image: 'https://upload.wikimedia.org/wikipedia/en/a/a7/Ffxboxart.jpg', active?: true, inventory: 3)
      @FFX_game2 = @scott.items.create!(name: 'FFX2', description: "FFX For ALL", price: 350, image: 'https://upload.wikimedia.org/wikipedia/en/a/a7/Ffxboxart.jpg', active?: true, inventory: 3)
    end

    describe "has_orders?" do
      it "returns true if merchant is on an order" do
        expect(@scott.has_orders?).to eq(false)
        @order = Order.create!(username: 'Christopher', address: '123 Oak', city: 'Denver', state: 'CO', zipcode: 80021)
        @order.order_items.create!(item: @FFX_game, price: @FFX_game.price, quantity: 1)
        expect(@scott.has_orders?).to eq(true)
      end
    end

    describe "average_prices" do
      it "returns the average prices of merchant items" do
        expect(@scott.average_prices).to eq(185)
      end
    end

    describe "cities_shipped_to" do
      it "returns the cities merchant has shipped to" do
        @order = Order.create!(username: 'Christopher', address: '123 Oak', city: 'Denver', state: 'CO', zipcode: 80021)
        @order.order_items.create!(item: @FFX_game, price: @FFX_game.price, quantity: 1)
        expect(@scott.cities_shipped_to).to eq(['Denver'])
      end
    end
end
end
