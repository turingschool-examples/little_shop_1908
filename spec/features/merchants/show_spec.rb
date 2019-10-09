require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: '23137')
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

end
