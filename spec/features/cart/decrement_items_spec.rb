require 'rails_helper'

describe "Cart page" do
  it "can decrement the count of items" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 3)

    visit "/items/#{@chain.id}"
    click_button("Add Item")

    visit '/cart'

    click_button "+1"

    click_button "-1"

    expect(page).to have_content('Qty: 1')

    click_button "-1"

    expect(page).to_not have_content('Chain')
  end
end