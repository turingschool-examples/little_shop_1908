require 'rails_helper'

describe 'User visits merchant page with no items or orders' do
  it "Shows alternative text instead of blanks" do
    bob = Merchant.create(name: 'Bob Ross Supplies', address: '123 Happy Tree St.', city: 'Lalaland', state: 'CA', zip: 90827)

    visit "/merchants/#{bob.id}"

    within '.merchant-stats' do
      expect(page).to have_content("Count of items: 0")
      expect(page).to have_content("Average price: No items for #{bob.name} yet")
      expect(page).to have_content("Customer locations: #{bob.name} has not shipped any orders yet")
      within '.top-reviewed-items' do
        expect(page).to have_content("No reviews for #{bob.name}'s items yet")
      end
    end
  end
end
