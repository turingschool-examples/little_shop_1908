require 'rails_helper'

describe "New order page" do
  it "can see details of cart" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/items/#{@chain.id}"

    click_button "Add Item"

    visit '/cart'

    click_link 'Checkout'

    visit '/orders/new'

    expect(page).to have_content('Chain')
    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to have_content('Price: 50')
    expect(page).to have_content('Qty: 1')
    expect(page).to have_content('Subtotal: 50')
    expect(page).to have_content('Total Amount: 50')

    expect(page).to have_content('Shipping Information')

    fill_in :name, with: 'Michael Jackson'
    fill_in :address, with: '123 Neverland Ranch Rd'
    fill_in :city, with: 'Hollywood'
    fill_in :state, with: 'California'
    fill_in :zip, with: '90210'

    expect(page).to have_button('Create Order')
  end
end