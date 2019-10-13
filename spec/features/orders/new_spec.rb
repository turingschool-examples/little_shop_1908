require 'rails_helper'

RSpec.describe 'New Order Page', type: :feature do
  describe 'As a visitor' do
    describe 'when I check out from my cart and visit the new order page' do
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

        visit '/cart/new_order'
      end

      it 'I see the details of my cart' do
        within "#item-#{@tire.id}" do
          expect(page).to have_content(@tire.name)
          expect(page).to have_content(@meg.name)
          expect(page).to have_content(@tire.price)
          expect(page).to have_content('Quantity: 2')
          expect(page).to have_content('Subtotal: $200')
        end

        within "#item-#{@chain.id}" do
          expect(page).to have_content(@chain.name)
          expect(page).to have_content(@meg.name)
          expect(page).to have_content(@chain.price)
          expect(page).to have_content('Quantity: 1')
          expect(page).to have_content('Subtotal: $50')
        end

        expect(page).to have_content('Grand Total: $250')
      end

      it 'I see a form to enter my shipping info and a Create Order button' do
        expect(page).to have_field(:name)
        expect(page).to have_field(:address)
        expect(page).to have_field(:city)
        expect(page).to have_field(:state)
        expect(page).to have_field(:zip)
        expect(page).to have_button('Create Order')
      end
    end
  end
end
