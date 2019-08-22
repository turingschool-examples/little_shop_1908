require 'rails_helper'

describe 'Cart Show Page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
  end
#   When I have added items to my cart
# And I visit my cart ("/cart")
# I see all items I've added to my cart
# Each item in my cart shows the following information:
# - the name of the item
# - the item image
# - the merchant I'm buying this item from
# - the price of the item
# - my desired quantity of the item
# - a subtotal (price multiplied by quantity)
# I also see a grand total of what everything in my cart will cost
  it "displays the items in the cart and other pertinent info" do
    visit "/cart"

    expect(page).to have_content("Your cart is empty, yo.")

    visit "/items/#{@tire.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/items/#{@dog_bone.id}"

    click_button "Add Item To yo Cart"

    visit "/cart"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content("Purchase 1 at $100.00 each")
      expect(page).to have_content("Subtotal: $100.00")
    end

    within "#cart-item-#{@dog_bone.id}" do
      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      expect(page).to have_content(@dog_bone.merchant.name)
      expect(page).to have_content("Purchase 2 at $21.00 each")
      expect(page).to have_content("Subtotal: $42.00")
    end

    expect(page).to have_content("Total Cost: $142.00")
  end 
end
