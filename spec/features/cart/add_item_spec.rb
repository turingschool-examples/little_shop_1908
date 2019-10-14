require 'rails_helper'

RSpec.describe 'From item show page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/items/#{@chain.id}"
  end

  it 'I can add the item to cart' do
    click_button 'Add to Cart'

    expect(page).to have_content("#{@chain.name} has been added to cart! You now have 1 Chain in your cart.")
    expect(current_path).to eq('/items')
    expect(page).to have_link('Cart: 1')
  end
end
