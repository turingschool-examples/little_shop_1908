require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'when I visit the merchant index page' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    end

    it 'I can see a list of merchants in the system' do
      img_merchant = "https://image.flaticon.com/icons/svg/679/679946.svg"
      visit '/merchants'

      expect(page).to have_link("#{@bike_shop.name}")
      expect(page).to have_link("#{@dog_shop.name}")
      expect(page).to have_css("img[src*='#{img_merchant}']")
    end

    it 'I can see a link to create a new merchant' do
      visit '/merchants'

      expect(page).to have_link("New Merchant")

      click_on "New Merchant"

      expect(current_path).to eq("/merchants/new")
    end
  end
end
