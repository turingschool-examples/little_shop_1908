require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click create order' do
    it 'I am taken to the order show page and it displays order information' do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 50.00, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 25.05, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 50.00, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 4)
      items = { "#{@tire.id}" => 2, "#{@chain.id}" => 1, "#{@shifter.id}" => 3}
      cart = Cart.new(items)
      order = Order.create!(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', grand_total: 275.05, creation_date: '10/22/2019')
      @tire.item_orders.create(item_quantity: 2, item_subtotal: 100.00, order_id: order.id)
      @chain.item_orders.create(item_quantity: 1, item_subtotal: 25.05, order_id: order.id)
      @shifter.item_orders.create(item_quantity: 3, item_subtotal: 150.00, order_id: order.id)


      visit "/orders/#{order.id}"

      within "#ship_to" do
        expect(page).to have_content('Ship to:')
        expect(page).to have_content('Richy Rich')
        expect(page).to have_content('102 Main St')
        expect(page).to have_content('NY')
        expect(page).to have_content('New York')
        expect(page).to have_content('10221')
      end


      within "#item-#{@tire.id}" do
        expect(page).to have_content('Gatorskins')
        expect(page).to have_content("Sold by: Meg's Bike Shop")
        expect(page).to have_content('Price: $50.00')
        expect(page).to have_content('Quantity: 2')
        expect(page).to have_content('Subtotal: $100.00')
      end

      within "#item-#{@chain.id}" do
        expect(page).to have_content('Chain')
        expect(page).to have_content("Sold by: Meg's Bike Shop")
        expect(page).to have_content('Price: $25.05')
        expect(page).to have_content('Quantity: 1')
        expect(page).to have_content('Subtotal: $25.05')
      end

      within "#item-#{@shifter.id}" do
        expect(page).to have_content('Shimano Shifters')
        expect(page).to have_content("Sold by: Meg's Bike Shop")
        expect(page).to have_content('Price: $50.00')
        expect(page).to have_content('Quantity: 3')
        expect(page).to have_content('Subtotal: $150.00')
      end
    
      expect(page).to have_content('Your order total: $275.05')
      expect(page).to have_content('Date order was placed: 10/22/2019')
    end
  end
end
