require 'rails_helper'

RSpec.describe 'item delete', type: :feature do
  describe 'when I visit an item show page' do

    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    end

    it 'can delete an item' do
      visit "/items/#{@chain.id}"
      click_link "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{@chain.id}")
    end

    it 'can delete an items reviews by deleting the item' do
      great = @chain.reviews.create(title: 'Great Chain!', content: 'Keeps on going.', rating: 5)
      not_worth_it = @chain.reviews.create(title: 'Not worth it', content: 'Too expensive for what you get', rating: 2)
      meh = @chain.reviews.create(title: 'Meh.', content: 'Alright chain I guess', rating: 3)

      expect(Review.where(item_id: @chain.id)).to eq([great, not_worth_it, meh])

      visit "/items/#{@chain.id}"
      click_link "Delete Item"

      expect(Review.where(item_id: @chain.id)).to eq([])
    end

    it 'cannot delete an item that has been ordered' do
      user = User.create(name: 'Kyle Pine', address: '123 Main Street', city: 'Greenville', state: 'NC', zip: '29583')
      order = user.orders.create(grand_total: 100, verification_code: '3856758493')
      order.item_orders.create(item_id: @chain.id, item_quantity: 2, subtotal: 50)

      visit "/items/#{@chain.id}"
      click_link "Delete Item"

      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to have_content('Item has been ordered and cannot be deleted')
    end

  end
end
