require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'on the create new merchant page' do
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

    it 'I see alert flash messages when form is filled with only name and address' do
      visit '/merchants/new'

      fill_in :name, with: "Merchant"
      fill_in :address, with: "123 Road"

      click_button "Create Merchant"

      expect(current_path).to eq('/merchants/new')

      expect(page).to have_content("City can't be blank, State can't be blank, and Zip can't be blank")
    end

    it 'I see alert flash messages when form is only filled with city, state, and zip' do
      visit '/merchants/new'

      fill_in :city, with: "Merchant"
      fill_in :state, with: "Merchant"
      fill_in :zip, with: "Merchant"

      click_button "Create Merchant"

      expect(current_path).to eq('/merchants/new')

      expect(page).to have_content("Name can't be blank and Address can't be blank")
    end

  end
end
