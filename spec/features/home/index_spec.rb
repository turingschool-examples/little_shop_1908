require 'rails_helper'

RSpec.describe "Home Page" do
  it "should show shop name and image" do
    img_bike = "https://image.flaticon.com/icons/svg/685/685784.svg"
    img_dog = "https://image.flaticon.com/icons/svg/620/620851.svg"

    visit '/'

    expect(page).to have_link("Little Shop")
    expect(page).to have_link("All Merchants")
    expect(page).to have_link("All Items")
    expect(page).to have_link("Cart")
    expect(page).to have_css("img[src*='#{img_bike}']")
    expect(page).to have_css("img[src*='#{img_dog}']")
  end
end
