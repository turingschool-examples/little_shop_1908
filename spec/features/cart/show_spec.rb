require 'rails_helper'

describe 'When I visit my cart' do
  it 'I see all the items in the cart' do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{pull_toy.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'
    visit "/items/#{dog_bone.id}"
    click_link 'Add to Cart'

    within "#cart-indicator" do
      click_link
    end

    expect(current_path).to eq('/cart')
    within "#cart-item-#{pull_toy.id}" do
      expect(page).to have_css("img[src*='http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg']")
      within ".details-description" do
        expect(page).to have_content(pull_toy.name)
        expect(page).to have_content(pull_toy.merchant.name)
      end
      within ".details-price" do
        expect(page).to have_content(pull_toy.price)
      end
      within ".details-quantity" do
        expect(page).to have_content("1")
      end
      within ".details-subtotal" do
        expect(page).to have_content("$10.00")
      end
    end

    within "#cart-item-#{dog_bone.id}" do
      expect(page).to have_css("img[src*='https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg']")
      within ".details-description" do
        expect(page).to have_content(dog_bone.name)
        expect(page).to have_content(dog_bone.merchant.name)
      end
      within ".details-price" do
        expect(page).to have_content(dog_bone.price)
      end
      within ".details-quantity" do
        expect(page).to have_content("2")
      end
      within ".details-subtotal" do
        expect(page).to have_content("$42.00")
      end
    end

    within ".order-total" do
      expect(page).to have_content("Order total: $52.00")
    end

    within ".checkout-btn" do
      click_link("Checkout")
    end
    expect(current_path).to eq('/orders/new')
  end
end
