require 'rails_helper'

describe 'When I visit my cart' do
  before :each do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  end

  it 'I can increase item quantity' do

    visit "/items/#{@pull_toy.id}"
    click_link 'Add to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add to Cart'

    visit '/cart'

    within "#cart-item-#{@pull_toy.id}" do
      within ".details-quantity" do
      expect(page).to have_link("+ 1")
      end
    end

    within "#cart-item-#{@pull_toy.id}" do
      within ".details-quantity" do
        click_link "+ 1"
      end

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

    within "#cart-item-#{@pull_toy.id}" do
      31.times {click_link "+ 1"}
    end

    expect(page).to have_content("Item out of stock")
    end

  it 'I can decrease item quantity' do
    visit "/items/#{@pull_toy.id}"
    click_link 'Add to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add to Cart'
    visit "/items/#{@tire.id}"
    click_link 'Add to Cart'

    visit '/cart'

    within "#cart-item-#{@tire.id}" do
      within ".details-quantity" do
        expect(page).to have_link("- 1")
      end
    end

    within "#cart-item-#{@tire.id}" do
      within ".details-quantity" do
        click_link "- 1"
      end

      expect(current_path).to eq('/cart')

      within ".details-quantity" do
        expect(page).to have_content("1")
      end

      within ".details-subtotal" do
        expect(page).to have_content("$100.00")
      end

      click_link "- 1"
    end
    expect(page).to_not have_content(@tire.name)
  end
end
