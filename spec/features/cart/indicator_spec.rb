require 'rails_helper'

describe "Cart Indicator" do
  it 'I see a cart indicator in the navigation bar' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit '/'

    within "#cart-indicator" do
      expect(page).to  have_css("img[src*='https://cdn0.iconfinder.com/data/icons/shopping-cart-26/1000/Shopping-Basket-03-512.png']")
      expect(page).to have_content("(0)")
    end

    visit "/items/#{pull_toy.id}"
    click_link 'Add to Cart'

    within "#cart-indicator" do
      expect(page).to have_content("(1)")
    end

    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'

    within "#cart-indicator" do
      expect(page).to have_content("(2)")
    end
  end
end
