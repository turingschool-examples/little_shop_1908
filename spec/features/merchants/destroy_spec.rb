require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When a merchant has no orders" do
    describe "When I visit a merchant show page" do
      before :each do
        @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
        @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      end

      it "I can delete a merchant" do

        visit "merchants/#{@bike_shop.id}"

        click_on "Delete Merchant"

        expect(current_path).to eq('/merchants')
        expect(page).to_not have_content("Brian's Bike Shop")
      end

      it "When I delete a merchant, it deletes its items" do
        visit '/merchants'
        expect(page).to have_css("#merchant-#{@bike_shop.id}")

        visit "merchants/#{@bike_shop.id}"

        click_on "Delete Merchant"

        expect(current_path).to eq('/merchants')
        expect(page).to_not have_content("Brian's Bike Shop")
        expect(page).to_not have_css("#merchant-#{@bike_shop.id}")

        visit "/items"
        expect(page).to_not have_css("#item-#{@chain.id}")
      end
    end
  end

  describe "When a merchant has orders" do
    it "I cannot delete the merchant because there is no delete button" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit "/merchants/#{dog_shop.id}"

      expect(page).to have_link('Delete Merchant')

      cart = Cart.new( {"#{dog_bone.id}" => "1"} )
      order = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      order.create_item_orders(cart)

      visit "/merchants/#{dog_shop.id}"

      expect(page).to_not have_link('Delete Merchant')
    end
  end
end
