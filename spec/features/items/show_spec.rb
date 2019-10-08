require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before(:each) do
    @review_1 = create(:chain_review_1)
    @review_2 = create(:chain_review_2)
    visit "items/#{@review_1.item.id}"
  end
  it 'shows item info' do
    within("#item-show-#{@review_1.item.id}") do
      expect(page).to have_link(@review_1.item.merchant.name)
      expect(page).to have_content(@review_1.item.name)
      expect(page).to have_content(@review_1.item.description)
      expect(page).to have_content("Price: $#{@review_1.item.price}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@review_1.item.inventory}")
      expect(page).to have_content("Sold by: #{@review_1.item.merchant.name}")
      expect(page).to have_css("img[src*='#{@review_1.item.image}']")
    end
  end
  it 'shows all item reviews' do
    within("#item-review-#{@review_1.id}") do
      expect(page).to have_content("Best Chain evur")
      expect(page).to have_content("It never broke!")
      expect(page).to have_content('5')
    end

    within("#item-review-#{@review_2.id}") do
      expect(page).to have_content("Wurst Chain evur")
      expect(page).to have_content("It broke!")
      expect(page).to have_content('1')
    end
  end
end
