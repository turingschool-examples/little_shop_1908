require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end
    it 'Has merchant statistics' do
      tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = @bike_shop.items.create(name: "Chain", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      order_1 = Order.create(name: "Bob", address: "234 A st.", city: "Torrance", state: "CA", zip: 90505)
      order_2 = Order.create(name: "Phil", address: "456 A st.", city: "Lake Forest", state: "IL", zip: 60045)
      item_order_1 = order_1.item_orders.create(quantity: 1, total_cost: 100, item: tire)
      item_order_2 = order_2.item_orders.create(quantity: 1, total_cost: 40, item: chain)

      visit "/merchants/#{@bike_shop.id}"
      within ".merchant-stats" do
        expect(page).to have_content("Count of items: 2")
        expect(page).to have_content("Average price: $70.00")
        expect(page).to have_content("Customer locations: Lake Forest, Torrance")
      end
    end
    it 'Has top three reviewed merchant items' do
      tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = @bike_shop.items.create(name: "Chain", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      light = @bike_shop.items.create(name: "Light", description: "Its a light!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      horn = @bike_shop.items.create(name: "Horn", description: "Its a chain!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
      review_1 = tire.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 2)
      review_2 = chain.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 1)
      review_3 = light.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 3)
      review_4 = horn.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 4)

      visit "/merchants/#{@bike_shop.id}"
      within ".merchant-stats" do
        expect(page).to have_content("Top reviewed items: #{horn.name} (#{review_4.rating}), #{light.name} (#{review_3.rating}), #{tire.name} (#{review_1.rating})")
      end
    end
  end
end
