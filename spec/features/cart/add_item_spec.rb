require 'rails_helper'

RSpec.describe "As a Visitor" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  end
  it "When I add an item to a cart" do

    visit "/items/#{@tire.id}"

    expect(page).to have_button("Add to Cart")

    within "#item-#{@tire.id}" do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have added #{@tire.name} in your cart.")
  end
end
