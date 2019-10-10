require 'rails_helper'

RSpec.describe "Cart show page", type: :feature do
  before(:each) do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @bike_shop.items.create!(name: "Tire", description: "This is a tire.", price: 30, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 7)
    visit "/items/#{@chain.id}"
    click_link 'Add Item to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add Item to Cart'
  end
  it "shows info of all items in cart with grand total" do
    visit '/cart'

    within "#cart-#{@chain.id}" do
      expect(page).to have_content(@chain.name)
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content(@chain.merchant.name)
      expect(page).to have_content(@chain.price)
      expect(page).to have_content("Count: 1")
      expect(page).to have_content("Subtotal: $50.00")
    end

    within "#cart-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content(@tire.price)
      expect(page).to have_content("Count: 1")
      expect(page).to have_content("Subtotal: $30.00")
    end

    expect(page).to have_content("Grand Total: $80.00")
  end
end
