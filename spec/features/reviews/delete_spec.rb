require 'rails_helper'

RSpec.describe 'Delete Review' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @scott = Merchant.create!(name: 'Scotts GCUBE GAMES', address: '123 Sesame St', city: 'Denver', state: 'CO', zip: 80011)
        @animal_crossing = @scott.items.create!(name: 'Animal Crossing', description: "Video Game", price: 50, image: 'https://images-na.ssl-images-amazon.com/images/I/51D98VK2RWL.jpg', active?: true, inventory: 5 )
        @ac_review_1 = @animal_crossing.reviews.create!(title: 'Bad Game', content: 'Ive played better...jk i love it', rating: 5)
      end

      it 'I can click a link to delete a review' do
        visit "/items/#{@animal_crossing.id}"
        click_link("Delete Review", :match => :first)
        visit "/items/#{@animal_crossing.id}"
        expect(page).to_not have_css("#review-#{@ac_review_1.id}")
      end
    end
  end
end
