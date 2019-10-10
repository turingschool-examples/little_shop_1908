require 'rails_helper'

RSpec.describe 'site navigation' do

  it "can see a nav bar with links to all pages" do
    visit '/merchants'

    within('nav') { click_link 'All Items' }
    expect(current_path).to eq('/items')

    within('nav') { click_link 'All Merchants' }
    expect(current_path).to eq('/merchants')

    within('nav') { click_link 'Cart (0)' }
    expect(current_path).to eq('/cart')
  end

end
