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

    # As a visitor
    # When I am updating or creating a new merchant
    # If I try to submit the form with incomplete information
    # I see a flash message indicating which field(s) I am missing
    describe 'flash messasge for incomplete form specific to each field' do
      it 'empty zip flash message' do
        visit '/merchants/new'

        fill_in :name, with: "Sammie's Socks"
        fill_in :address, with: 'One Merchant Road'
        fill_in :city, with: 'Cash City'
        fill_in :state, with: 'MD'


        click_button 'Create Merchant'

        expect(page).to have_content("Zip can't be blank")
      end

      it 'empty state flash message' do
        visit '/merchants/new'

        fill_in :name, with: "Sammie's Socks"
        fill_in :address, with: 'One Merchant Road'
        fill_in :city, with: 'Cash City'
        fill_in :zip, with: '10456'


        click_button 'Create Merchant'

        expect(page).to have_content("State can't be blank")
      end

      it 'empty city flash message' do
        visit '/merchants/new'

        fill_in :name, with: "Sammie's Socks"
        fill_in :address, with: 'One Merchant Road'
        fill_in :state, with: 'MD'
        fill_in :zip, with: '10456'


        click_button 'Create Merchant'

        expect(page).to have_content("City can't be blank")
      end

      it 'empty address flash message' do
        visit '/merchants/new'

        fill_in :name, with: "Sammie's Socks"
        fill_in :city, with: 'Cash City'
        fill_in :state, with: 'MD'
        fill_in :zip, with: '10456'

        click_button 'Create Merchant'

        expect(page).to have_content("Address can't be blank")
      end

      it 'empty zip flash message' do
        visit '/merchants/new'

        fill_in :address, with: 'One Merchant Road'
        fill_in :city, with: 'Cash City'
        fill_in :state, with: 'MD'
        fill_in :zip, with: '10456'

        click_button 'Create Merchant'

        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
