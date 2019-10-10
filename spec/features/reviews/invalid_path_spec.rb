require 'rails_helper'

RSpec.describe 'invalid review id for URL path', type: :feature do
  describe 'As a user, when I attempt to visit an invalid edit page' do

    it 'cannot view a review edit page for an item that does not exist' do

      visit '/reviews/3253/edit'

      expect(page).to have_content 'That review could not be found.'
      expect(current_path).to eq('/items')
    end

    it 'cannot view a review edit page for a review that does not exist' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/reviews/3253/edit"
      expect(page).to have_content 'That review could not be found.'
      expect(current_path).to eq("/items")
    end
  end
end
