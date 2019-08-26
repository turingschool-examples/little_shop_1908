require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end

    it "When I visit a merchant's show page, I see statistics for that
    merchant, including: count of items for that merchant, average price of
    that merchant's items, and distinct cities where my items have been
    ordered, and I see the top 3 highest rated items for that merchant (by average rating)" do

      item_1 = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      item_2 = @bike_shop.items.create!(name: "Bike Lights", description: "So bright!", price: 25, image: "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiW-NjQv6HkAhUCt54KHYLkAJwQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FCycle-Torch-Bolt-Combo-Rechargeable%2Fdp%2FB01N2HZV9U&psig=AOvVaw36ygs9M0LDALlZHfp40GLF&ust=1566941906310951", inventory: 7)
      item_3 = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      review_1 = item_1.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
      review_2 = item_2.reviews.create!(title: "Win!", content: "These ARE lights!!", rating: 5)
      review_3 = item_3.reviews.create!(title: "Yay", content: "I can ride my bike now!", rating: 5)

      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_content("#{@bike_shop.name}'s Top Three Items")
      within ".top-reviews" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
      end
    end
  end
end
