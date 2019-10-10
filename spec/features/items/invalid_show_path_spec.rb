require 'rails_helper'

RSpec.describe 'invalid URL for item number', type: :feature do
  describe 'As a user, when I attempt to visit an invalid show page' do

    it "cannot view a page for an item that does not exist" do

      visit "/items/3412"

      expect(page).to have_content 'That page could not be found.'
      expect(current_path).to eq('/items')
    end
  end
end
