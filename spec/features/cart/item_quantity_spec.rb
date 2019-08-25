require 'rails_helper'

describe 'When I visit my cart' do
  it 'I can increase item quantity' do
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
      within ".add-item-quantity" do
      expect(page).to have_link("Add 1: #{pull_toy.name}")
      end
    end

    within "#cart-item-#{pull_toy.id}" do
      click_link "Add 1: #{pull_toy.name}"
      expect(current_path).to eq('/cart')

      within ".details-quantity" do
        expect(page).to have_content("2")
      end
      within ".details-subtotal" do
        expect(page).to have_content("$20.00")
      end
    end

    within ".order-total" do
      expect(page).to have_content("Order total: $220.00")
    end

    within "#cart-item-#{pull_toy.id}" do
      31.times do click_link "Add 1: #{pull_toy.name}"
    end
  end
  expect(page).to have_content("Item out of stock")
  end

  it 'I can decreasee item quantity' do
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

    within "#cart-item-#{tire.id}" do
      within ".decrease-item-quantity" do
        expect(page).to have_link("Remove 1: #{tire.name}")
      end
    end

    within "#cart-item-#{tire.id}" do
      click_link "Remove 1: #{tire.name}"
      expect(current_path).to eq('/cart')

      within ".details-quantity" do
        expect(page).to have_content("1")
      end
      within ".details-subtotal" do
        expect(page).to have_content("$100.00")
      end
    end

    within ".order-total" do
      expect(page).to have_content("Order total: $110.00")
    end
  end
end

# As a visitor
# When I have items in my cart
# And I visit my cart
# Next to each item in my cart
# I see a button or link to increment the count of items I want to purchase
# I cannot increment the count beyond the item's inventory size
