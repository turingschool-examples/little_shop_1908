require 'rails_helper'

describe 'User visits the item show page' do
  describe 'They can click a link and fill in form to add review' do
    it 'Can create a new review' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      # review = chain.reviews.create(title: "It's Great!", content: "Best chain ever!", rating: 3)

      visit "/items/#{chain.id}"

      expect(page).to have_link("New Review")
      click_link "New Review"

      expect(current_path).to eq("/items/#{chain.id}/reviews/new")
      fill_in :title, with: 'Boo'
      fill_in :content, with: 'This chain sucks, I wish I could give it a 0'
      fill_in :rating, with: 1

      click_on("Submit")
      expect(current_path).to eq("/items/#{chain.id}")
      expect(page).to have_content("Boo")
      end
    end

    describe 'If user leaves part of form blank' do
      it 'Gives flash message to do it right' do
        bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

        visit "/items/#{chain.id}"

        click_link 'New Review'

        fill_in :title, with: "Great Chain"

        click_on 'Submit'
        expect(page).to have_content("Please fill in all the fields.")
      end
    end
  end