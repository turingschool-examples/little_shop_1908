require 'rails_helper'

describe "Item New Page" do
  before(:each) do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
  end

  xit 'has a form to create a new item' do
    visit "/merchants/#{@dog_shop.id}/items/new"

    name = "Chamois Buttr"
    price = 18
    description = "No more chaffin'!"
    image_url = "https://images-na.ssl-images-amazon.com/images/I/51HMpDXItgL._SX569_.jpg"
    inventory = 25

    fill_in :name, with: name
    fill_in :price, with: price
    fill_in :description, with: description
    fill_in :image, with: image_url
    fill_in :inventory, with: inventory

    click_button "Create Item"

    new_item = Item.last

    expect(current_path).to eq("/merchants/#{@dog_shop.id}/items")
    expect(new_item.name).to eq(name)
    expect(new_item.price).to eq(price)
    expect(new_item.description).to eq(description)
    expect(new_item.image).to eq(image_url)
    expect(new_item.inventory).to eq(inventory)
    expect(Item.last.active?).to be(true)
    expect(page).to have_css("#item-#{Item.last.id}")
    expect(page).to have_content(name)
    expect(page).to have_content("Price: $#{new_item.price}")
    expect(page).to have_css("img[src*='#{new_item.image}']")
    expect(page).to have_content("Active")
    expect(page).to_not have_content(new_item.description)
    expect(page).to have_content("Inventory: #{new_item.inventory}")
  end
end
