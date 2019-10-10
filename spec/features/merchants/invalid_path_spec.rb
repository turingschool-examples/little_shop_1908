require 'rails_helper'

RSpec.describe 'invalid merchant id for URL path', type: :feature do
  describe 'As a user, when I attempt to visit an invalid show page' do

    it 'cannot view a show page for a merchant that does not exist' do

      visit '/merchants/323'

      expect(page).to have_content 'That page could not be found.'
      expect(current_path).to eq('/merchants')
    end
  end

  describe 'As a user, when I attempt to visit an invalid edit page' do

    it 'cannot view an edit page for a merchant that does not exist' do

      visit '/merchants/323/edit'

      expect(page).to have_content 'That page could not be found.'
      expect(current_path).to eq('/merchants')
    end
  end
end
