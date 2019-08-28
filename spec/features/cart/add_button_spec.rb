require 'rails_helper'

describe "User visits items show page and clicks Add to Cart" do
  before(:each) do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  end

  it 'Redirects them to items index with flash message about updated cart' do

    visit "/items/#{@pull_toy.id}"
    expect(page).to have_link('Add to Cart')

    click_link 'Add to Cart'

    expect(current_path).to eq('/items')
    expect(page).to have_content("#{@pull_toy.name} added to cart.")
  end

  it 'Increments the cart count in the cart indicator' do
    dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{@pull_toy.id}"
    click_link 'Add to Cart'
    within "#cart-indicator" do
      expect(page).to have_content("(1)")
    end
  end
end
