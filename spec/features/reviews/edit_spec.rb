require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit an item show page and click edit review' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @review_1 = @chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
      visit "/items/#{@chain.id}"
      click_link 'Edit Review'
    end


    it 'I can see the prepopulated fields of that review' do
      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
      expect(page).to have_link('Chain')
      expect(find_field(:title).value).to eq('Worst chain!')
      expect(find_field(:content).value).to eq('NEVER buy this chain.')
      expect(find_field(:rating).value).to eq('1')
    end

    it 'I can change and update the review with the form' do
      fill_in :title, with: 'Abominable chain!'
      fill_in :content, with: 'Hell nah.'
      fill_in :rating, with: '1'

      click_button 'Update Review'

      expect(current_path).to eq("/items/#{@chain.id}")

      expect(page).to have_content('Review updated!')

      expect(page).to have_content('Abominable chain!')
      expect(page).to have_content('Hell nah')
      expect(page).to have_content('1')

      expect(page).to_not have_content('Worst chain!')
      expect(page).to_not have_content('NEVER buy this chain.')
    end
  end
end
