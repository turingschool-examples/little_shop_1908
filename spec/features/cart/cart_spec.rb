require 'rails_helper'

RSpec.describe 'Cart Creation' do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end

  it "As a visitor, when I visit an item's show page from the items index
  I see a link or button to add this item to my cart" do
    visit item_path(@chain.id)

    expect(current_path).to eq(item_path(@chain.id))
    expect(page).to have_link "Add To Cart"
  end

  it "And I click this link or button and I am returned to the item index page" do
    visit item_path(@chain.id)
    click_on "Add To Cart"

    expect(current_path).to eq(items_path)
  end

  it "I see a flash message indicating the item has been added to my cart" do
    visit item_path(@chain.id)
    click_on "Add To Cart"

    expect(page).to have_content("#{@chain.name} has been added to your cart!")
  end

  it "The cart indicator in the navigation bar increments my cart count" do
    visit item_path(@chain.id)

    expect(page).to have_content("Cart: 0")

    click_on "Add To Cart"

    expect(page).to have_content("Cart: 1")
  end

end
