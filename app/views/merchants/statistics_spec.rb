require 'rails_helper'

RSpec.describe 'Merchant Show Page', type: :feature do
  before(:each) do

    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    @order_1 = Order.create(name: 'David', address: '4942 willow street', city: 'Denver', state: 'Co', zip: 80238)
    @order_2 = Order.create(name: 'Ryan', address: '4942 willow street', city: 'Aurora', state: 'Co', zip: 80238)
    @order_3 = Order.create(name: 'Scott', address: '4942 willow street', city: 'Englewood', state: 'Co', zip: 80238)

    @order_1.order_items.create(item: @tire, price: @tire.price, quantity: 2)
    @order_1.order_items.create(item: @chain, price: @chain.price, quantity: 1)
    @order_2.order_items.create(item: @tire, price: @tire.price, quantity: 2)
    @order_3.order_items.create(item: @chain, price: @chain.price, quantity: 4)
  end

  it 'can see merchant statistics' do
    visit "/merchants/#{@bike_shop.id}"

    within '#merchant-stats' do
      expect(page).to have_content("Items: #{@bike_shop.items.count}")
      expect(page).to have_content("Average Item Price: #{ @bike_shop.average_item_price}")
      # expect(page).to have_content("Average Item Price: #{ 75}")
      expect(page).to have_content("Cities where items have been ordered:")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Aurora")
      expect(page).to have_content('Englewood')
    end
  end
end
