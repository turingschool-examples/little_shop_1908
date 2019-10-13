require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I have added items to my cart and visit my cart" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    end
    it "I see all items that have been added to my cart" do
      visit "/items/#{@tire.id}"

      click_button 'Add to Cart'

      visit "/items/#{@tire.id}"

      click_button 'Add to Cart'

      visit "/items/#{@chain.id}"

      click_button 'Add to Cart'

      visit '/cart'

      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content("Sold by: #{@meg.name}")
      expect(page).to have_content("Price: #{@tire.price}")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Subtotal: #{2*@tire.price}")


      expect(page).to have_content(@chain.name)
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content("Sold by: #{@meg.name}")
      expect(page).to have_content("Price: #{@chain.price}")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Subtotal: #{@chain.price}")

      expect(page).to have_content("Grand Total: #{@chain.price + (2*@tire.price)}")
    end

    it 'A message appears saying there are no items when the cart is empty' do
      visit '/cart'

      expect(page).to have_content('Your cart is empty')
    end

    it 'I can click a button to empty my cart' do
      visit "/items/#{@tire.id}"

      click_button 'Add to Cart'

      visit '/cart'

      click_button 'Empty Cart'

      expect(current_path).to eq('/cart')

      expect(page).to have_content('Your cart is empty')
      expect(page).to have_content('Cart: 0')
    end

    it 'I can remove individual items in my cart' do
      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'

      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'

      visit "/items/#{@chain.id}"
      click_button 'Add to Cart'

      visit '/cart'

      within ("#item-#{@tire.id}") do
        expect(page).to have_button('Remove Item')
        click_button 'Remove Item'
      end

      expect(current_path).to eq('/cart')

      expect(page).to_not have_content(@tire.name)
      expect(page).to_not have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@chain.name)
    end

    it 'I see a button to checkout' do
      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'

      visit "/items/#{@chain.id}"
      click_button 'Add to Cart'

      visit '/cart'

      expect(page).to have_button('Checkout')

      click_button 'Checkout'

      expect(current_path).to eq('/cart/new_order')
    end
  end
end
