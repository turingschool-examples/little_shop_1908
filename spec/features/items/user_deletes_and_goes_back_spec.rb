require 'rails_helper'

describe 'User deletes item from show page and goes back' do
  it 'Should redirect to items index with flash message' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{pull_toy.id}"
    click_link 'Delete Item'

    visit "/items/#{pull_toy.id}"
    expect(current_path).to eq('/items')
    expect(page).to have_content("Sorry, that item does not exist")

  end
end
