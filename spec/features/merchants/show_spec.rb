require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      visit "/merchants/#{@bike_shop.id}"
    end

    it 'I can see a merchants name, address, city, state, zip' do
      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end


    describe 'I see a merchant stats section' do
      it "has the total count of unique items sold by the merchant" do
        within "#merchant-stats" do
          expect(page).to have_content("Number of Items: 2")
        end
      end

      it "has the average price of all items sold by the merchant" do
        within "#merchant-stats" do
          expect(page).to have_content("Average Price: $75")
        end
      end

      it "Shows a list of cities from which items have been ordered" do
        within "#merchant-stats" do
          cart = Cart.new({})
          cart.add_item(@tire.id)
          cart.add_item(@tire.id)
          @order_1 = Order.create(name: "Bob", address: "123 Street", city: "Denver", state: "CO", zip: "80232", grand_total: 250, verification: Order.generate_code)
          @order_1.generate_item_orders(cart)
          cart = Cart.new({})
          cart.add_item(@tire.id)
          cart.add_item(@chain.id)
          cart.add_item(@chain.id)
          @order_2 = Order.create(name: "Joe", address: "234 Drive", city: "Boston", state: "MA", zip: "10101", grand_total: 200, verification: Order.generate_code)
          @order_2.generate_item_orders(cart)
          cart = Cart.new({})
          cart.add_item(@chain.id)
          @order_3 = Order.create(name: "Sam", address: "345 Way", city: "Cambridge", state: "MA", zip: "10101", grand_total: 200, verification: Order.generate_code)
          @order_3.generate_item_orders(cart)

          visit "/merchants/#{@bike_shop.id}"

          expect(page).to have_content("Satisfied Customers In: Denver, Boston, and Cambridge")
        end
      end
    end
  end
end
