require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a merchant show page" do
    it "I can delete a merchant" do
      bike_shop = create(:brians_bike_shop)

      visit "merchants/#{bike_shop.id}"
      click_on "Delete Merchant"
      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can delete a merchant that has items" do
      item = create(:chain)
      visit "/merchants/#{item.merchant_id}"

      click_on "Delete Merchant"
      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end
  end
end
