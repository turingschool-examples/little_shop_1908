require 'rails_helper'

RSpec.describe Cart do
  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({"1" => 2, "2" => 3})

      expect(cart.total_count).to eq(5)
    end

    it "can return objects for the item ids it holds" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      cart = Cart.new({"#{tire.id}" => 1, "#{chain.id}" => 2})

      expect(cart.cart_items).to eq([tire, chain])
    end

    it "can calculate the subtotal for a given item" do

      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      cart = Cart.new("#{tire.id}" => 3)

      expect(cart.subtotal(tire.id)).to eq(300)
    end

    it "can calculate the grand total for a cart" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      cart = Cart.new({"#{tire.id}" => 1, "#{chain.id}" => 2})

      expect(cart.grand_total).to eq(200)
    end

    it "can subtract one from the quantity of an item in the cart" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      cart = Cart.new({"#{tire.id}" => 1, "#{chain.id}" => 2})

      cart.subtract_item("#{chain.id}")

      expect(cart.contents["#{chain.id}"]).to eq(1)
    end

    describe "#add_item" do
      it "can add an item to the cart" do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        cart = Cart.new({})
        cart.add_item(tire.id)

        expect(cart.contents.keys.include?(tire.id.to_s)).to eq(true)
      end

    end

    describe "#count_of" do
      it "it can count how many of a specific item are in the cart" do
        cart = Cart.new({"2" => 3, "41" => 17})

        expect(cart.count_of(2)).to eq(3)
        expect(cart.count_of(41)).to eq(17)
      end

    end
  end
end
