require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a merchant show page" do
    it "I can delete a merchant" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      visit "merchants/#{dog_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Dog Shop")
    end

    it "I can delete a merchant that has items" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      visit "merchants/#{dog_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Dog Shop")
    end

    it "If a merchant has items that have been ordered, I can not delete that merchant
    there is no link visible for me to delete the merchant" do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @order_1 = Order.create!(name: "Leiya Kelly", address: '11 ILiveAtTuring Ave.', city: "Denver", state: "CO", zip: 80237)
      @a = @order_1.order_items.create!(item_id: @chain.id, quantity: 1, price: @chain.price, name: @chain.name, merchant: @chain.merchant.name, subtotal: 50, merchant_id: @chain.merchant.id)

      visit "merchants/#{@bike_shop.id}"

      expect(page).to_not have_link("Delete Merchant")
    end
  end
end
