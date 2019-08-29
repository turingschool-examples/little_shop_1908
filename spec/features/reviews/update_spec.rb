require 'rails_helper'

RSpec.describe 'Update Review' do
  describe 'As a Visitor' do
    before :each do
      @scott = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @FFX_game = @scott.items.create!(name: 'FFX', description: "FFX For PS4", price: 20, image: 'https://upload.wikimedia.org/wikipedia/en/a/a7/Ffxboxart.jpg', active?: true, inventory: 5 )
      @FFX_review_1 = @FFX_game.reviews.create!(title: 'My thoughts', content: 'Engaging Video Game!', rating: 5)
    end

    it 'I can click a link to get to an review edit page' do
      visit "/items/#{@FFX_game.id}"

      click_link 'Edit Review'

      expect(current_path).to eq("/reviews/#{@FFX_review_1.id}/edit")
    end

    it 'I can edit the review information' do
      title = 'My thoughts'
      content = "Engaging Video Game!"
      rating = 5

      visit "/reviews/#{@FFX_review_1.id}/edit"

      fill_in 'Title', with: title
      fill_in 'Content', with: content
      fill_in 'Rating', with: rating
      click_button 'Update Review'

      expect(current_path).to eq("/items/#{@FFX_game.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
    end
  end
end
