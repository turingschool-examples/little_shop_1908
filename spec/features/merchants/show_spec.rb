require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end

    it 'can show flash message when trying to visit nonexistent merchant show page' do
      visit '/merchants/2734027934'

      expect(page).to have_content('Merchant does not exist. Redirecting to Merchant index page.')

      expect(current_path).to eq('/merchants')
    end

    it 'cannot delete a merchant if they have items that have been ordered' do
      @chain = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 2)
      @tire = @bike_shop.items.create!(name: 'Tire', description: 'This is a tire.', price: 30, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 7)
      visit "/items/#{@chain.id}"
      click_link 'Add Item to Cart'

      visit '/cart'

      click_link 'Checkout'

      fill_in 'Customer name', with: 'Joe'
      fill_in 'Customer address', with: '123 Test Drive'
      fill_in 'Customer city', with: 'Denver'
      fill_in 'Customer state', with: 'CO'
      fill_in 'Customer zip', with: 80128

      click_button 'Create Order'

      visit "/merchants/#{@bike_shop.id}"

      expect(page).to_not have_link('Delete Merchant')
    end
  end
end
