require 'rails_helper'

RSpec.describe 'merchant edit' do
  describe 'After visiting a merchants show page and clicking on updating that merchant' do

    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 11234)

      visit "/merchants/#{@bike_shop.id}"
      click_link "Update Merchant"
    end

    it 'can see prepopulated info on that user in the edit form' do
      expect(page).to have_link(@bike_shop.name)
      expect(find_field('Name').value).to eq "Brian's Bike Shop"
      expect(find_field('Address').value).to eq '123 Bike Rd.'
      expect(find_field('City').value).to eq 'Richmond'
      expect(find_field('State').value).to eq 'VA'
      expect(find_field('Zip').value).to eq "11234"
    end

    it 'can edit merchant info by filling in the form and clicking submit' do
      fill_in 'Name', with: "Brian's Super Cool Bike Shop"
      fill_in 'Address', with: '1234 New Bike Rd.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80204'

      click_button "Update Merchant"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}")
      expect(page).to have_content("Brian's Super Cool Bike Shop")
      expect(page).to have_content("1234 New Bike Rd.\nDenver, CO 80204")
    end

    it 'flashes a message and redirects if form is not filled in' do
      fill_in 'Name', with: nil
      fill_in 'Address', with: nil
      fill_in 'City', with: nil
      fill_in 'State', with: nil
      fill_in 'Zip', with: nil

      click_button 'Update Merchant'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/edit")
    end

    it 'flashes a message and redirects if zip code has wrong format' do
      visit "/merchants/#{@bike_shop.id}/edit"

      fill_in :zip, with: '2461'
      click_button 'Update Merchant'
      expect(page).to have_content('Zip is the wrong length (should be 5 characters)')
      expect(current_path).to eq("/merchants/#{@bike_shop.id}/edit")

      fill_in :zip, with: '24611.2'
      click_button 'Update Merchant'
      expect(page).to have_content('Zip must be an integer')
      expect(current_path).to eq("/merchants/#{@bike_shop.id}/edit")
    end

  end
end
