require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    it 'I can delete an item' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/items/#{chain.id}"

      expect(page).to have_link("Delete Item")

      click_link "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{chain.id}")
    end

    it "When I delete an item, all reviews associated with that item are also
    deleted" do
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    review_1 = Review.create(title: "Womp Womp", content: "I hate it", rating: 1, item_id: chain.id)

    visit "/items/#{chain.id}"

    expect(page).to have_content(review_1.content)

    click_link "Delete Item"

    review_1.destroyed?
    end

    it "If an item has been ordered, I can not delete that item, there is no link visible for me to delete the item" do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      order_1 = Order.create!(name: "Leiya Kelly", address: '11 ILiveAtTuring Ave.', city: "Denver", state: "CO", zip: 80237)
      a = order_1.order_items.create!(item_id: chain.id, quantity: 1, price: chain.price, name: chain.name, merchant: chain.merchant.name, subtotal: 50, merchant_id: chain.merchant.id)

      visit "/items/#{chain.id}"

      expect(page).to_not have_link("Delete Item")


    end
  end
end
