require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click checkout from my cart page' do
    before(:each) do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
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
    it 'displays all order information' do

      expect(current_path).to eq('/orders/new')

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

      expect(page).to have_content('Grand Total: $275.05')
    end

    it 'provides a form for me to enter my shipping information' do

      within "#shipping_info" do
        expect(page).to have_content('Please enter your shipping information:')
        fill_in 'Name', with: 'Richy Rich'
        fill_in 'Address', with: "102 Main Street"
        fill_in 'City', with: "New York"
        fill_in 'State', with: "New York"
        fill_in 'Zip code', with: "10221"
      end
    end

    it 'displays button for creating order' do
      expect(page).to have_button 'Create Order'
    end

  end
end
