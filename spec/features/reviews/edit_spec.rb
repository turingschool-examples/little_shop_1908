require 'rails_helper'

RSpec.describe "review edit" do
  describe "when I visit an item show page" do

    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @review_1 = @chain.reviews.create(title: "It'll never break!", content: 'Great chain!', rating: 5)
      @review_2 = @chain.reviews.create(title: 'Rusts quickly', content: 'Oil it frequently', rating: 3)

      visit "/items/#{@chain.id}"
    end

    it 'can see a link to edit each review' do
      within "#review-#{@review_1.id}" do
        expect(page).to have_link('Edit Review')
      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_link('Edit Review')
      end
    end

    it 'can see the prepopulated fields of that review in edit form' do
      within "#review-#{@review_1.id}" do
        click_link('Edit Review')
      end

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
      expect(page).to have_link(@chain.name)
      expect(find_field('Title').value).to eq "It'll never break!"
      expect(find_field('Content').value).to eq 'Great chain!'
      expect(find_field('Rating').value).to eq '5'
    end

    it 'can change and update review with the form' do
      within "#review-#{@review_1.id}" do
        click_link('Edit Review')
      end

      fill_in :title, with: "Won't stop squeaking"
      fill_in :content, with: 'Not even grease can fix it.'
      fill_in :rating, with: 2

      click_button 'Update Review'

      expect(current_path).to eq("/items/#{@chain.id}")

      within "#review-#{@review_1.id}" do
        expect(page).to have_content("Won't stop squeaking")
        expect(page).to have_content('Not even grease can fix it.')
        expect(page).to have_content('Rating: 2')

        expect(page).to_not have_content("It'll never break!")
        expect(page).to_not have_content('Great chain!')
        expect(page).to_not have_content('Rating: 5')
      end
    end

    it 'shows a flash message when fields are blank' do
      visit "/reviews/#{@review_1.id}/edit"

      fill_in :title, with: nil
      fill_in :content, with: nil
      fill_in :rating, with: nil

      click_button 'Update Review'

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Content can't be blank")
      expect(page).to have_content("Rating can't be blank")
    end

    it 'shows a flash message when fields are blank' do
      visit "/reviews/#{@review_1.id}/edit"

      fill_in :rating, with: "Not a number"

      click_button 'Update Review'
      
      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
      expect(page).to have_content("Rating is not a number")
    end
  end
end
