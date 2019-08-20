
require 'rails_helper'

describe 'Site Navigation Bar' do
  it "appears on all pages with links to all items" do
    visit '/merchants'

    within 'nav' do
      click_link 'All Items'
    end

    expect(current_path).to eq('/items')
  end

  it "appears on all pages with links to all merchants" do
    visit '/items'

    within 'nav' do
      click_link 'All Merchants'
    end

    expect(current_path).to eq('/merchants')
  end
end
