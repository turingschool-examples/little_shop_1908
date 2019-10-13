require 'rails_helper'

RSpec.describe 'Order Creation' do
  describe 'As a visitor' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'

      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'

      visit "/items/#{@chain.id}"
      click_button 'Add to Cart'
    end

    it 'when I complete all info on the new order page and click Create Order, I redirect to order show page' do
      visit '/cart/new_order'

      fill_in :name, with: "Sam"
      fill_in :address, with: "123 Main St."
      fill_in :city, with: "Anytown"
      fill_in :state, with: "MZ"
      fill_in :zip, with: "80122"

      click_button 'Create Order'

      expect(current_path).to eq("/order/#{Order.first.id}")

      expect(page).to have_content('Sam')
      expect(page).to have_content('123 Main St')
      expect(page).to have_content('Anytown')
      expect(page).to have_content('MZ')
      expect(page).to have_content('80122')

      within "#item-#{@chain.id}" do
        expect(page).to have_content(@chain.name)
        expect(page).to have_content(@meg.name)
        expect(page).to have_content("$#{@chain.price}")
        expect(page).to have_content('Quantity: 1')
        expect(page).to have_content('Subtotal: $50')
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@meg.name)
        expect(page).to have_content("$#{@tire.price}")
        expect(page).to have_content('Quantity: 2')
        expect(page).to have_content('Subtotal: $200')
      end

      expect(page).to have_content('Grand Total: $250')
    end
  end
end
