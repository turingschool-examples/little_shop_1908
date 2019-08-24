require 'rails_helper'

describe "Item Index Page" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
  end

  it 'has links to all item and merchant names' do
    visit '/items'

    expect(page).to have_link(@tire.name)
    expect(page).to have_link(@tire.merchant.name)
    expect(page).to have_link(@pull_toy.name)
    expect(page).to have_link(@pull_toy.merchant.name)
    expect(page).to have_link(@dog_bone.name)
    expect(page).to have_link(@dog_bone.merchant.name)
  end

  it "has a list of the items and their info" do
    visit '/items'

    within "#item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_content(@tire.description)
      expect(page).to have_content("Price: $#{@tire.price}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@tire.inventory}")
      expect(page).to have_content("Sold by: #{@bike_shop.name}")
      expect(page).to have_css("img[src*='#{@tire.image}']")
    end

    within "#item-#{@pull_toy.id}" do
      expect(page).to have_content(@pull_toy.name)
      expect(page).to have_content(@pull_toy.description)
      expect(page).to have_content("Price: $#{@pull_toy.price}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
      expect(page).to have_content("Sold by: #{@dog_shop.name}")
      expect(page).to have_css("img[src*='#{@pull_toy.image}']")
    end

    within "#item-#{@dog_bone.id}" do
      expect(page).to have_content(@dog_bone.name)
      expect(page).to have_content(@dog_bone.description)
      expect(page).to have_content("Price: $#{@dog_bone.price}")
      expect(page).to have_content("Inactive")
      expect(page).to have_content("Inventory: #{@dog_bone.inventory}")
      expect(page).to have_content("Sold by: #{@dog_shop.name}")
      expect(page).to have_css("img[src*='#{@dog_bone.image}']")
    end
  end

  describe "displays a flash message when an item is added to the cart" do
    it "if the addition is successful" do
      visit "items/#{@dog_bone.id}"

      click_button "Add Item To yo Cart"

      expect(current_path).to eq("/items")
      expect(page).to have_content("1 #{@dog_bone.name} has been added. You now have 1 #{@dog_bone.name} in your cart.")

      visit "items/#{@dog_bone.id}"

      click_button "Add Item To yo Cart"

      expect(current_path).to eq("/items")
      expect(page).to have_content("1 #{@dog_bone.name} has been added. You now have 2 #{@dog_bone.name} in your cart.")
    end

    it "if the addition is unsuccessful" do
      rope_knot = @dog_shop.items.create(name: "Rope Knot", description: "It's a rope tied in a knot.", price: 16, image: "https://cdn.shopify.com/s/files/1/0389/5389/products/HOBIE_taupe_1512x.jpg?v=1554748124", inventory: 0)

      visit "items/#{rope_knot.id}"

      click_button "Add Item To yo Cart"

      expect(current_path).to eq("/items")
      expect(page).to have_content("There are not enough #{rope_knot.name} to add to yo cart, sry.")
    end
  end

end
