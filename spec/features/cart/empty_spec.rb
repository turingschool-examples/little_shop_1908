require 'rails_helper'

describe 'User visits full cart' do
  it 'Should have link that removes items from cart' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'

    visit "/cart"
    expect(page).to have_link("Empty your cart")
    click_link("Empty your cart")

    expect(current_path).to eq('/cart')
    expect(page).to_not have_css("img[src*='https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg']")
    expect(page).to_not have_content(dog_bone.name)
    expect(page).to_not have_content(dog_bone.merchant.name)
    expect(page).to_not have_content(dog_bone.price)
    expect(page).to_not have_content("2")
    expect(page).to_not have_content("$42.00")

    expect(page).to have_content("Order total: $0.00")
  end
end
