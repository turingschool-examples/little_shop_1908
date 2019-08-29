require "rails_helper"

describe "When user adds item to cart" do
  before(:each) do
     @scott = Merchant.create!(name: 'scotts games', address: '842 g st', city: 'Denver', state: 'CO', zip: 80011)
     @vg_1 = @scott.items.create!(name: 'halo 3', description: "Halo 3 for XBOX360", price: 40, image: 'https://images-na.ssl-images-amazon.com/images/I/81JHQU3xX-L._SY679_.jpg', active?: true, inventory: 5 )
     @vg_2 = @scott.items.create!(name: 'smash bros', description: "Smash for wii ", price: 50, image: 'https://images-na.ssl-images-amazon.com/images/I/81aJ-R4E6gL._AC_SX430_.jpg', active?: true, inventory: 3 )
   end

  it "displays message that tells you what has been added to cart" do
   visit '/items'

   within("#item-#{@vg_1.id}") do
     click_button "Add Item"
   end

   within("#item-#{@vg_1.id}") do
     click_button "Add Item"
   end

   expect(page).to have_content("You now have 2 copies of #{@vg_1.name} in your cart.")
 end

  it "display an accurate number for number of items currently in the cart" do
    visit '/items'

    expect(page).to have_content("Cart: 0")

    within("#item-#{@vg_1.id}") do
      click_button "Add Item"
    end

    expect(page).to have_content("Cart: 1")

    within("#item-#{@vg_2.id}") do
      click_button "Add Item"
    end

    expect(page).to have_content("Cart: 2")

    within("#item-#{@vg_1.id}") do
      click_button "Add Item"
    end

    expect(page).to have_content("Cart: 3")
  end
end
