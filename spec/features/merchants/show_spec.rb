require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a visitor' do
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

    it "When I visit a merchant's show page, I see statistics for that
    merchant, including: count of items for that merchant, average price of
    that merchant's items, and distinct cities where my items have been
    ordered" do

      @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @order_1 = Order.create!(name: "Leiya Kelly", address: '11 ILiveAtTuring Ave.', city: "Denver", state: "CO", zip: 80237)
      @a = @order_1.order_items.create!(item_id: @chain.id, quantity: 1, price: @chain.price, name: @chain.name, merchant: @chain.merchant.name, subtotal: 50, merchant_id: @chain.merchant.id)

      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content(@bike_shop.count_of_items)
      expect(page).to have_content("Items From This Merchant: 2")
      expect(page).to have_content(@bike_shop.average_price)
      expect(page).to have_content("Average Price: 75")
      expect(page).to have_content("Cities: Denver")
    end
  end
end
