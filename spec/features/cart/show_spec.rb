require 'rails_helper'

describe "Visit cart show page" do
  it "can see all items in cart" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = @bike_shop.items.create!(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

    visit "/items/#{@chain.id}"

    click_button("Add Item")

    visit "/items/#{@chain.id}"

    click_button("Add Item")

    visit "items/#{@shifter.id}"

    click_button("Add Item")

    visit "/cart"

    expect(page).to have_content('Chain')
    expect(page).to have_css("img[src='#{@chain.image}']")
    expect(page).to have_content('50')
    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to have_content("Qty: 2")
    expect(page).to have_content("Subtotal: 100")

    expect(page).to have_content('Shifter')
    expect(page).to have_css("img[src='#{@shifter.image}']")
    expect(page).to have_content('180')
    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to have_content("Qty: 1")
    expect(page).to have_content("Subtotal: 180")

    expect(page).to have_content("Total Amount: 280")
  end

  it "see's no items in cart" do

    visit '/cart'

    expect(page).to have_content("Your cart is empty")
    expect(page).to_not have_content('Chain')
    expect(page).to_not have_content("Subtotal")
  end

  it "see's Checkout button", type: :feature do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @shifter = @bike_shop.items.create!(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

    visit "/items/#{@chain.id}"

    click_button("Add Item")

    visit "items/#{@shifter.id}"

    click_button("Add Item")

    visit "/cart"

    click_button "Checkout"
    expect(current_path).to eq('/order')
    expect(page).to have_content("Order")
  end
 end
