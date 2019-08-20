require 'rails_helper'

RSpec.describe "As a Visitor" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @dog_bone = @meg.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
  end

  it "I can add an item to a cart" do

    visit "/items/#{@tire.id}"

    expect(page).to have_button("Add to Cart")

    within "#item-info" do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 1 copy of #{@tire.name} in your cart.")
  end

  it "I cannot add an inactive item to a cart" do

    visit "/items/#{@dog_bone.id}"

    expect(page).to have_button("Add to Cart")

    within "#item-info" do
      click_button "Add to Cart"
    end

    expect(current_path).to eq("/items/#{@dog_bone.id}")

    expect(page).to have_content("You cannot add #{@dog_bone.name} to your cart because it is inactive.")
  end
end
