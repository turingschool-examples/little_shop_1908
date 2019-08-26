require 'rails_helper'

RSpec.describe 'Cart Show Page', type: :feature do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  end

  it "When I have added items to my cart and I visit my cart, I see all items I've added to my cart" do
    visit item_path(@chain.id)
    click_on "Add To Cart"
    visit item_path(@tire.id)
    click_on "Add To Cart"

    visit "/cart"

    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@tire.name)
  end

  it "Each item in my cart shows the name, image, merchant, price, my desired quantity, a subtotal (price * quantity)" do
    visit item_path(@chain.id)
    click_on "Add To Cart"
    visit item_path(@tire.id)
    click_on "Add To Cart"

    visit "/cart"

      expect(page).to have_content(@chain.name)
      expect(page).to have_css("img[src*='#{@chain.image}']")
      expect(page).to have_content(@chain.merchant.name)
      expect(page).to have_content(@chain.price)
      expect(page).to have_content("Total Quantity: 1")
      expect(page).to have_content("Subtotal: $50")

      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content(@tire.price)
      expect(page).to have_content("Total Quantity: 1")
      expect(page).to have_content("Subtotal: $100")
  end

  it "I also see a grand total of what everything in my cart will cost" do
    visit item_path(@chain.id)
    click_on "Add To Cart"
    visit item_path(@tire.id)
    click_on "Add To Cart"

    visit "/cart"

    expect(page).to have_content("Grand Total: $150")
  end

  it "When I add NO items to my cart yet, and I visit my cart,
   I see a message that my cart is empty, I do NOT see the link to empty my cart" do
    visit "/cart"

    expect(page).to have_content("Oops! You have no items in your cart!")
    expect(page).to_not have_content("Grand Total: $")
    expect(page).to_not have_button("Empty Cart")
  end
end
