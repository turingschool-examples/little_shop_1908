require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
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

    it "can see stats for our merchant" do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      visit "/items/#{@tire.id}"
      click_button "Add Item"
      visit '/cart'
      click_link 'Checkout'
      visit '/orders/new'

      fill_in :name, with: 'Michael Jackson'
      fill_in :address, with: '123 Neverland Ranch Rd'
      fill_in :city, with: 'Hollywood'
      fill_in :state, with: 'California'
      fill_in :zip, with: '90210'

      click_button "Create Order"

      visit "/merchants/#{@meg.id}"

      expect(page).to have_content("Item Count: 1")
      expect(page).to have_content("Average Item Price: 100")
      expect(page).to have_content("Cities With Order: Hollywood")

    end

  end
end
