require 'rails_helper'

describe 'User adds item to cart and then tries to delete that item from merchant items page' do
  it "does not allow item to be deleted" do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    visit "/items/#{pull_toy.id}"
    click_on 'Add to Cart'

    visit "/items/#{pull_toy.id}"
    expect(page).to_not have_link('Delete Item')
  end
end
