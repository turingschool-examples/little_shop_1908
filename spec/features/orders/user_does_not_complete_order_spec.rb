require 'rails_helper'

describe 'User does not complete the order form fully' do
  it "Displays flash error and redirects to page" do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{pull_toy.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'
    visit '/cart'
    click_link 'Checkout'

    name = "Ian Douglas"
    address = '123 Testing Pl.'
    city = "Denver"
    state = "CO"
    zip = 80204

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city

    click_button 'Place Order'
    
    expect(page).to have_content('Please fill in all the fields')
    expect(page).to have_button('Place Order')
  end
end
