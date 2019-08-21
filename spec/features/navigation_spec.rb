
require 'rails_helper'

describe 'Site Navigation Bar' do
  it "has a link to the item index page" do
    visit '/merchants'

    within '.topnav' do
      click_link 'All Items'
    end

    expect(current_path).to eq('/items')
  end

  it "has a link to the merchant index page" do
    visit '/items'

    within '.topnav' do
      click_link 'All Merchants'
    end

    expect(current_path).to eq('/merchants')
  end

  it "has a cart indicator that links to the cart page and shows the number of added items" do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{pull_toy.id}"

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 0")
      expect(page).to have_xpath("//img[contains(@src, pug_cart.png)]")
    end

    click_button "Add Item To yo Cart"

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 1")
    end

    visit "/items/#{dog_bone.id}"

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 1")
    end

    click_button "Add Item To yo Cart"

    within '.topnav' do
      expect(page).to have_link("Items in Cart: 2")
    end
  end
end
