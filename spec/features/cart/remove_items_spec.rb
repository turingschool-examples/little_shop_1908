require 'rails_helper'

describe "cart page", type: :feature do
  it "can delete items from cart" do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = @bike_shop.items.create!(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

    visit "/items/#{@chain.id}"
    click_button("Add Item")

    visit "/items/#{@shifter.id}"
    click_button("Add Item")

    visit '/cart'

    within "#cart-#{@chain.id}" do
      click_button "Delete Item"
    end

    expect(page).to_not have_content('Chain')
    expect(page).to have_content("Shimano Shifters")
  end
end
