require 'rails_helper'

describe "cart page", type: :feature do
  it "can empty cart" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/items/#{@chain.id}"

    click_button("Add Item")

    visit '/cart'

    click_link "Empty Cart"
    expect(current_path).to eq('/cart')
    expect(page).to have_content("Your cart is empty")
    expect(page).to have_content("Cart: 0")
  end
end
