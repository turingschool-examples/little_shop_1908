require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a merchant show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "merchants/#{@bike_shop.id}"
    end
    it "I can delete a merchant" do
      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can delete a merchant that has items" do
      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it 'I cannot delete a merchant that has orders' do
      items = { "#{@chain.id}" => 1 }
      cart = Cart.new(items)
      order = Order.create!(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', grand_total: 25.05, creation_date: '10/22/2019')
      @chain.item_orders.create(item_quantity: 1, item_subtotal: 25.05, order_id: order.id)

      click_on "Delete Merchant"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}")
      expect(page).to have_content("Cannot delete, this merchant has orders in progress.")
    end

    it 'I can delete a merchant that has items in the cart but not ordered' do
      visit "/items/#{@chain.id}"
      click_button 'Add to Cart'
      visit "/merchants/#{@bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to have_link('Cart: 0')
      expect(page).to_not have_content("Brian's Bike Shop")
    end
  end
end
