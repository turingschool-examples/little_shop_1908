require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: '23137')
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end

  it 'can see a merchants name, address, city, state, zip' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
  end

  it 'can see a link to visit the merchant items' do
    visit "/merchants/#{@bike_shop.id}"
    click_link "All #{@bike_shop.name} Items"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
  end

  it 'flashes an error and redirects to index if no merchant exists' do
    visit '/merchants/2'

    expect(page).to have_content('Merchant does not exist')
    expect(current_path).to eq('/merchants')
  end

  it 'can see the total number of items a merchant has' do
    visit "/merchants/#{@bike_shop.id}"
    
    expect(page).to have_content("Total Items: 1")

    chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_content("Total Items: 2")
  end

  it 'can see the average price of all their items' do
    chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    visit "/merchants/#{@bike_shop.id}"
    
    expect(page).to have_content("Average Item Price: $66.67")
  end 
end
