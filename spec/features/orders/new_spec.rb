require 'rails_helper'

RSpec.describe "As A Visitor" do
  describe "New Order" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      visit item_path(@chain.id)
      click_on "Add To Cart"
      visit item_path(@tire.id)
      click_on "Add To Cart"
      visit "/cart"

      click_on "Checkout"
    end
    it "On the new order page I see the details of my cart: name of item,
    merchant, price,desired quantity, subtotal, grand total of cart" do

    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.merchant.name)
    expect(page).to have_content(@chain.price)
    expect(page).to have_content("Total Quantity: 1")
    expect(page).to have_content("Subtotal: $50")

    expect(page).to have_content(@tire.name)
    expect(page).to have_content(@tire.merchant.name)
    expect(page).to have_content(@tire.price)
    expect(page).to have_content("Total Quantity: 1")
    expect(page).to have_content("Subtotal: $100")

    expect(page).to have_content("Grand Total: $150")
    end
    it "I also see a form to where I must enter my shipping information for the order:
    name, address, city, state, zip" do
      within(".order") do
        expect(page).to have_content("Name")
        expect(page).to have_content("Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zip")
      end
    end
    it "I also see a button to 'Create Order'" do
      expect(page).to have_button("Create Order")
    end
  end
end
