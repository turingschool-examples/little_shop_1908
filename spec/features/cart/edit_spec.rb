require 'rails_helper'

RSpec.describe "Emptying Cart" do
  describe "should empty the cart" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    end

    it "As a visitor, when I have items in my cart and I visit my cart and I click the link to empty my cart, then I am returned to my cart" do
      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"

      visit "/cart"
      expect(page).to have_link("Empty Cart")

      click_link("Empty Cart")
      expect(current_path).to eq("/cart")
    end

    it "All items have been completely removed from my cart" do
      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"

      visit "/cart"
      click_link("Empty Cart")

      expect(page).not_to have_content(@chain.name)
      expect(page).not_to have_content(@tire.name)

      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@chain.id)
      click_on "Add To Cart"

      visit "/cart"
      click_link("Empty Cart")

      expect(page).not_to have_content(@chain.name)
    end

    it "The navigation bar shows 0 items in my cart" do
      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"

      visit "/cart"
      click_link("Empty Cart")

      expect(page).to have_content("Cart: 0")
    end
  end
end
