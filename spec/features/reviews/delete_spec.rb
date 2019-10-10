require 'rails_helper'

describe 'On an items show page, I see a button next to each review to Delete' do
  describe 'I click the button to delete.'
    before(:each) do

    end

    it 'Im returned to the item show page and no longer see the review.' do

      visit "/items/#{@item.id}"

      click_on 'Delete Review'

    end
end
