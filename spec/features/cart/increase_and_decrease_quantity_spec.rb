require 'rails_helper'

RSpec.describe "As a user" do
  describe "When I visit my cart and I have items in it" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'
      visit "/items/#{@tire.id}"
      click_button 'Add to Cart'
      visit "/items/#{@chain.id}"
      click_button 'Add to Cart'
    end
    it "I see a button that I can click to increase quantity of an item by one" do
      visit '/cart'

      within "#item-#{@tire.id}" do
        expect(page).to have_button('+')

        click_button '+'

        expect(page).to have_content("Quantity: 3")
      end

      within "#item-#{@chain.id}" do
        expect(page).to have_button('+')

        expect(page).to have_content('Quantity: 1')
      end
    end

    it "I can't increase my cart quantity past the item's inventory size" do
      visit '/cart'
      within "#item-#{@tire.id}" do
        click_button '+'
        click_button '+'
      end

      expect(page).to have_content("You cannot purchase any more of those; the merchant doesn't have that many.")
    end
  end
end
