require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit an items show page' do
    describe 'It has a new review link' do
      before(:each) do
        bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        visit "/items/#{@chain.id}"
      end
      
      it 'leads to a new review form' do

        click_link 'Add new review'

        fill_in "title", with: "BEST EVER"
        fill_in "content", with: "SUPER BEST EVER"
        select "3", from: :rating

        click_button "Add Review"

        expect(current_path).to eq("/items/#{@chain.id}")
        expect(page).to have_content("BEST EVER")
        expect(page).to have_content("SUPER BEST EVER")
        expect(page).to have_content("3")
      end

      it "shows a flash message when form is incomplete" do
        click_link 'Add new review'

        click_button "Add Review"
        expect(page).to have_content("Please complete all fields.")
      end
    end
  end
end
