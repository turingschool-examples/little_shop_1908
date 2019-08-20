require 'rails_helper'

describe "Item Edit Page" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  end

  xit 'has a form to update an item with prepopulated info' do
    visit "/items/#{@tire.id}/edit"

    expect(find_field('Name').value).to eq(@tire.name)
    expect(find_field('Price').value).to eq(@tire.price)
    expect(find_field('Description').value).to eq(@tire.description)
    expect(find_field('Image').value).to eq(@tire.image)
    expect(find_field('Inventory').value).to eq(@tire.inventory)

    fill_in 'Name', with: "GatorSkins"
    fill_in 'Price', with: 110
    fill_in 'Description', with: "They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail."
    fill_in 'Image', with: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588"
    fill_in 'Inventory', with: 11

    click_button "Update Item"

    expect(current_path).to eq("/items/#{@tire.id}")
    expect(page).to have_content("GatorSkins")
    expect(page).to_not have_content("Gatorskins")
    expect(page).to have_content("Price: $110")
    expect(page).to have_content("Inventory: 11")
    expect(page).to_not have_content("Inventory: 12")
    expect(page).to_not have_content("Price: $100")
    expect(page).to have_content("They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail.")
    expect(page).to_not have_content("They'll never pop!")
  end
end
