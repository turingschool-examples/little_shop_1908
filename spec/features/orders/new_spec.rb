require 'rails_helper'

describe 'User clicks link to go to new order page' do
  it 'Displays cart information and shipping info form' do
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

    within "#order-item-#{pull_toy.id}" do
      expect(page).to have_content(pull_toy.name)
      expect(page).to have_content(pull_toy.merchant.name)
      expect(page).to have_content(pull_toy.price)
      within ".details-quantity" do
        expect(page).to have_content("1")
      end

      within  ".details-subtotal" do
        expect(page).to have_content("$10.00")
      end
    end

    within "#order-item-#{dog_bone.id}" do
      expect(page).to have_content(dog_bone.name)
      expect(page).to have_content(dog_bone.merchant.name)
      expect(page).to have_content(dog_bone.price)
      within ".details-quantity" do
        expect(page).to have_content("2")
      end

      within  ".details-subtotal" do
        expect(page).to have_content("$42.00")
      end
    end

    within ".order-total" do
      expect(page).to have_content("Order total: $52.00")
    end

    name = "Sal"
    address = '123 Kindalikeapizza Dr.'
    city = "Denver"
    state = "CO"
    zip = 80204

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Place Order"
  end
end

describe 'User clicks link to Place Order' do
  it "Creates a new order and redirects to the order show page" do
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
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Place Order"

    order = Order.last

    expect(current_path).to eq("/orders/#{order.id}")
    within ".customer-info" do
      expect(page).to have_content(name)
      expect(page).to have_content(address)
      expect(page).to have_content(city)
      expect(page).to have_content(state)
      expect(page).to have_content(zip)
    end

    within "#order-item-#{pull_toy.id}" do
      expect(page).to have_content(pull_toy.name)
      expect(page).to have_content(pull_toy.merchant.name)
      expect(page).to have_content(pull_toy.price)
      within ".details-quantity" do
        expect(page).to have_content("1")
      end

      within  ".details-subtotal" do
        expect(page).to have_content("$10.00")
      end
    end

    within "#order-item-#{dog_bone.id}" do
      expect(page).to have_content(dog_bone.name)
      expect(page).to have_content(dog_bone.merchant.name)
      expect(page).to have_content(dog_bone.price)
      within ".details-quantity" do
        expect(page).to have_content("2")
      end

      within  ".details-subtotal" do
        expect(page).to have_content("$42.00")
      end
    end

    within ".order-total" do
      expect(page).to have_content("Order total: $52.00")
    end

    within ".order-date" do
      expect(page).to have_content(order.created_at)
    end
  end
end
