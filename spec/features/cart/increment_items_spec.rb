require 'rails_helper'

describe "cart page" do
  it "can increment items" do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 3)

    visit "/items/#{@chain.id}"
    click_button("Add Item")

    visit '/cart'

    within "#cart-#{@chain.id}" do
      click_button "+1"
      expect(page).to have_content("Qty: 2")
    end

    within "#cart-#{@chain.id}" do
      click_button "+1"
      expect(page).to have_content("Qty: 3")
    end
  end

  it "can not increment over the inventory amount" do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 2)

    visit "/items/#{@chain.id}"
    click_button("Add Item")

    visit '/cart'
    click_button "+1"
    click_button "+1"
    expect(page).to have_content("Item all out")
  end
end
