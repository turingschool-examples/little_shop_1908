require 'rails_helper'

describe 'When I visit my cart' do
  it 'I can remove specific items from the cart' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    visit "/items/#{pull_toy.id}"
    click_link 'Add to Cart'
    visit "/items/#{tire.id}"
    click_link 'Add to Cart'
    visit "/items/#{tire.id}"
    click_link 'Add to Cart'

    visit '/cart'

    within "#cart-item-#{pull_toy.id}" do
      expect(page).to have_link("Remove: #{pull_toy.name}")
    end

    click_link "Remove: #{pull_toy.name}"
    expect(current_path).to eq('/cart')
    expect(page).to_not have_css("img[src*='http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg']")

    within ".details-description" do
      expect(page).to_not have_content(pull_toy.name)
      expect(page).to_not have_content(pull_toy.merchant.name)
    end
    within ".details-price" do
      expect(page).to_not have_content("Price: #{pull_toy.price}")
    end
    within ".details-quantity" do
      expect(page).to_not have_content("Qty: 1")
    end
    within ".details-subtotal" do
      expect(page).to_not have_content("$10.00")
    end
    within ".order-total" do
      expect(page).to have_content("Order total: $200.00")
    end
  end
end
