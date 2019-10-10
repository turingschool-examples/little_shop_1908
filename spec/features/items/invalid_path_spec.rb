require 'rails_helper'

RSpec.describe 'invalid item id for URL path', type: :feature do
  describe 'As a user, when I attempt to visit an invalid show page' do

    it 'cannot view a show page for an item that does not exist' do

      visit '/items/3412'

      expect(page).to have_content 'That page could not be found.'
      expect(current_path).to eq('/items')
    end
  end

  describe 'As a user, when I attempt to visit an edit page that doesnt exist' do

    it 'cannot edit an item that does not exist' do

      visit '/items/533/edit'

      expect(page).to have_content 'That page could not be found.'
      expect(current_path).to eq('/items')
    end
  end

end
