require 'rails_helper'

RSpec.describe "When a user adds items to their cart" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end

  it "displays a confirmation message" do

    visit "/items/#{@tire.id}"

    click_button 'Add to Cart'

    expect(page).to have_content("You now 1 copy of #{@tire.name} in your cart.")
  end

  it "the message correctly increments for multiple items" do
    visit "/items/#{@tire.id}"

    click_button 'Add to Cart'

    visit "/items/#{@chain.id}"

    click_button 'Add to Cart'

    visit "/items/#{@tire.id}"

    click_button 'Add to Cart'

    expect(page).to have_content("You now 2 copies of #{@tire.name} in your cart")
  end

  it "displays total number of items in cart" do
    visit "/items/#{@tire.id}"

    expect(page).to have_content("Cart: 0")

    click_button 'Add to Cart'

    expect(page).to have_content("Cart: 1")

    visit "/items/#{@chain.id}"

    click_button("Add to Cart")

    expect(page).to have_content("Cart: 2")

    visit "/items/#{@tire.id}"

    click_button("Add to Cart")

    expect(page).to have_content("Cart: 3")
  end
end
