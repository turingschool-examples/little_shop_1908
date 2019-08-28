require 'rails_helper'

describe 'User visits empty cart' do
  it 'Should give flash message of empty cart, with no link to empty cart' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/cart"

    expect(page).to have_content("Your cart is empty")
    expect(page).to_not have_link("Empty your cart")

    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'

    visit "/cart"
    expect(page).to_not have_content("Your cart is empty")
    expect(page).to have_link("Empty your cart")
  end
end
