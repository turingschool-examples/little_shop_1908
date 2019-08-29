require 'rails_helper'
include ActionView::Helpers::NumberHelper

describe 'New Order Page' do
  describe 'As a Visitor' do
    before :each do
      @pie_shop = Merchant.create(name: 'Pie Shop', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80001)
      @donut_shop = Merchant.create(name: 'Donut Shop', address: '321 Main St', city: 'Denver', state: 'CO', zip: 80233)
      @pie = @pie_shop.items.create(name: 'Pie', description: "Yummy Pie!", price: 15, image:"https://images-na.ssl-images-amazon.com/images/I/511RQsDqUgL._SX522_.jpg", inventory: 2 )
      @donut = @donut_shop.items.create(name: 'Donut', description: "Delicious Donut!", price: 3, image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Glazed-Donut.jpg/1920px-Glazed-Donut.jpg(364 kB)https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Glazed-Donut.jpg/1920px-Glazed-Donut.jpg', inventory: 10 )
    end

    it 'On the new order page I see the details of my cart' do
      visit "/items/#{@pie.id}"
      click_button 'Add Item'
      visit "/items/#{@donut.id}"
      click_button 'Add Item'

      visit '/cart'

      click_button 'Checkout'

      expect(current_path).to eq('/orders/new')
      expect(page).to have_content("Total: #{number_to_currency((@pie.price * 1) + (@donut.price * 1))}")

      within "#item-#{@pie.id}" do
        expect(page).to have_link(@pie.name)
        expect(page).to have_content("Price: #{number_to_currency(@pie.price)}")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: #{number_to_currency(@pie.price * 1)}")
        expect(page).to have_content("Sold by: #{@pie_shop.name}")
        expect(page).to have_link(@pie_shop.name)
      end

      within "#item-#{@donut.id}" do
        expect(page).to have_link(@donut.name)
        expect(page).to have_content("Price: #{number_to_currency(@donut.price)}")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: #{number_to_currency(@donut.price * 1)}")
        expect(page).to have_content("Sold by: #{@donut_shop.name}")
        expect(page).to have_link(@donut_shop.name)
      end
    end

    it 'I also see a form to where I must enter my shipping information for the order' do
      visit '/orders/new'

      expect(page).to have_field(:name)
      expect(page).to have_field(:address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zipcode)
      expect(page).to have_button('Create Order')
    end
  end
end
