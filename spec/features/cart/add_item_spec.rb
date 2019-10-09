require 'rails_helper'

RSpec.describe 'From item show page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
    @review_2 = @chain.reviews.create(title: "Awesome chain!", content: "This was a great chain! Would buy again.", rating: 5)
    @review_3 = @chain.reviews.create(title: "Meh", content: "Not the best.", rating: 2)
    @review_4 = @chain.reviews.create(title: "Okay", content: "Got the job done.", rating: 3)
    @review_5 = @chain.reviews.create(title: "Pretty Good", content: "Good chain, would probably buy again.", rating: 4)
    @review_6 = @chain.reviews.create(title: "Best chain EVER!", content: "So amazing, I'm in love.", rating: 5)

    visit "/items/#{@chain.id}"
  end

  it 'I can add the item to cart' do
    click_button 'Add to Cart'
    # save_and_open_page

    expect(page).to have_content("#{@chain.name} has been added to cart!")
    expect(current_path).to eq('/items')
    expect(page).to have_content('Cart: 1')
  end
end
