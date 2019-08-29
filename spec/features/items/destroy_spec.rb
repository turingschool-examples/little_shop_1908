require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      #tire reviews
      @review_1 = @tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
      @review_2 = @tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
      @review_3 = @tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)

      #order data
      @order_1 = Order.create(name: 'Corina', address: '1488 S Kenton St', city: 'Aurora', state: 'CO', zip: "80014")
        @item_2 = ItemOrder.create(order: @order_1, item: @dog_bone, quantity: 5, subtotal: @dog_bone.item_subtotal(5))

      end

    it 'I can delete an item' do

      visit "/items/#{@pull_toy.id}"

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{@pull_toy.id}")
    end

    it 'I can delete an item with reviews' do

      visit "/items/#{@tire.id}"

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{@tire.id}")
    end

    it 'cannot delete item if it has been ordered' do
      visit "/items/#{@dog_bone.id}"

      click_on 'Delete Item'

      expect(page).to have_content('This item has been ordered and cannot be deleted.')
    end

    it 'cannot delete item if the items is in a users cart' do

      visit "/items/#{@tire.id}"

      click_on 'Add Item'

      visit "/items/#{@tire.id}"

      click_on 'Delete Item'

      expect(page).to have_content("This item is in a user's cart and cannot be deleted.")
    end
  end
end
