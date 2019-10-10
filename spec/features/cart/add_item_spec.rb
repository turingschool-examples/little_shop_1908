require 'rails_helper'

RSpec.describe 'add item', type: :feature do

  before :each do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Bike Tire", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    visit "/items/#{@tire.id}"
  end

  it 'can add an item to cart from item show page' do
    click_button 'Add Item to Cart'

    expect(page).to have_content("Bike Tire has been added to your cart!")
    expect(current_path).to eq('/items')
    within('nav') { expect(page).to have_link('Cart (1)') }
    expect(current_path).to eq('/items')

    click_link(@tire.name)
    click_button 'Add Item to Cart'

    expect(page).to have_content("Bike Tire has been added to your cart!")
    expect(current_path).to eq('/items')
    within('nav') { expect(page).to have_link('Cart (2)') }
  end

end
