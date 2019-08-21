
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end
  end
end

# As a visitor
# I see a cart indicator in my navigation bar
# The cart indicator shows a count of items in my cart
# I can see this cart indicator from any page in the application

RSpec.describe 'Cart Indicator' do
  describe 'As a visitor' do
    it "I see a nav bar with a cart indicator that displays the number of items in the cart" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(page).to have_css(".topnav")
    end
  end
end
