require 'rails_helper'

describe "Cart Indicator" do
  it 'I see a cart indicator in the navigation bar' do
    visit '/'

    within "#cart-indicator" do
      expect(page).to  have_css("img[src*='https://cdn0.iconfinder.com/data/icons/shopping-cart-26/1000/Shopping-Basket-03-512.png']")
      expect(page).to have_content("(0)")
    end
  end
end
