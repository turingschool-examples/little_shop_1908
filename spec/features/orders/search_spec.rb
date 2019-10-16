require 'rails_helper'

RSpec.describe 'As a visitor' do
  before(:each) do
    bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    @tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 50.00, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 25.05, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 50.00, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 4)

    2.times do
      visit "items/#{@tire.id}"
      click_button 'Add to Cart'
    end

    visit "items/#{@chain.id}"
    click_button 'Add to Cart'

    3.times do
      visit "items/#{@shifter.id}"
      click_button 'Add to Cart'
    end

    visit "/cart"

    click_button 'Proceed to checkout'
  end
  it 'I can search an order by verification code' do

    fill_in 'Name', with: 'Richy Rich'
    fill_in 'Address', with: "102 Main Street"
    fill_in 'City', with: "New York"
    fill_in 'State', with: "New York"
    fill_in 'Zip', with: "10221"
    click_button 'Create Order'

    within "#search_button" do
      order = Order.last

      visit '/'

      fill_in 'Order Verification Number', with: Order.codes.key(order.id)

      click_button 'Search'


      expect(current_path).to eq("/orders/#{order.id}/verified_order")
      expect(page).to have_link('Delete Order')
      expect(page).to have_link('Edit Order')
    end
  end
end
