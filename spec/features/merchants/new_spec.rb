require 'rails_helper'

RSpec.describe 'merchant new page', type: :feature do
  describe 'As a user' do
    it 'I can create a new merchant' do
      visit '/merchants/new'

      name = "Sal's Calz(ones)"
      address = '123 Kindalikeapizza Dr.'
      city = "Denver"
      state = "CO"
      zip = 80204

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button "Create Merchant"

      new_merchant = Merchant.last

      expect(current_path).to eq('/merchants')
      expect(page).to have_content(name)
      expect(new_merchant.name).to eq(name)
      expect(new_merchant.address).to eq(address)
      expect(new_merchant.city).to eq(city)
      expect(new_merchant.state).to eq(state)
      expect(new_merchant.zip).to eq(zip)
    end

    it "I'm told what fields I'm missing from my create form" do
      visit "/merchants/new"
      click_on "Create Merchant"

      fill_in 'Name', with: ""
      fill_in 'Address', with: "1234 New Bike Rd."
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: 80204

      click_button "Create Merchant"

      expect(page).to have_content("You must fill in a name")

      visit "/merchants/new"
      click_on "Create Merchant"

      fill_in 'Name', with: "Brian's Super Cool Bike Shop"
      fill_in 'Address', with: ""
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: 80204

      click_button "Create Merchant"
      expect(page).to have_content("You must fill in an address")

      visit "/merchants/new"
      click_on "Create Merchant"

      fill_in 'Name', with: "Brian's Super Cool Bike Shop"
      fill_in 'Address', with: "1234 New Bike Rd."
      fill_in 'City', with: ""
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: 80204

      click_button "Create Merchant"
      expect(page).to have_content("You must fill in a city")

      visit "/merchants/new"
      click_on "Create Merchant"

      fill_in 'Name', with: "Brian's Super Cool Bike Shop"
      fill_in 'Address', with: "1234 New Bike Rd."
      fill_in 'City', with: "Denver"
      fill_in 'State', with: ""
      fill_in 'Zip', with: 80204

      click_button "Create Merchant"
      expect(page).to have_content("You must fill in a state")

      visit "/merchants/new"
      click_on "Create Merchant"

      fill_in 'Name', with: "Brian's Super Cool Bike Shop"
      fill_in 'Address', with: "1234 New Bike Rd."
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: ""

      click_button "Create Merchant"
      expect(page).to have_content("You must fill in a zip code")
    end

  end
end
