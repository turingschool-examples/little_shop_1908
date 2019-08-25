require 'rails_helper'

describe 'Merchant Show Page' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
  end

  it "displays a merchant's name, address, city, state, zip" do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_content(@bike_shop.name)
    expect(page).to have_content("#{@bike_shop.address}\n#{@bike_shop.city}, #{@bike_shop.state} #{@bike_shop.zip}")
  end

  it 'has a link to visit the merchant items' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_link("All #{@bike_shop.name} Items")

    click_link "All #{@bike_shop.name} Items"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
  end

  it 'has a link to update the merchant info' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_link("Update Merchant")

    click_link "Update Merchant"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}/edit")
  end

  describe 'has a link to delete the merchant' do
    it 'if the merchant has no items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("Delete Merchant")

      click_link "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content(@bike_shop.name)
    end

    it 'if the merchant has items and no orders' do
      chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("Delete Merchant")

      click_link "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content(@bike_shop.name)
    end

    it "if merchant has active orders" do
      doggo_shop = Merchant.create(name: "E's Doggo Shop", address: '123 Dog Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      order = Order.create(name: "Evette", address: "123 street", city: "Denver", state: "CO", zip: 12345)
      io_1 = order.item_orders.create(item_id: tire.id, order_id: order.id, quantity: 5, total_cost: (tire.price * 5))

      visit "/merchants/#{@bike_shop.id}"
      click_link "Delete Merchant"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}")
      expect(page).to have_content("We won't delete merchants with active orders")

      visit "/merchants/#{doggo_shop.id}"
      click_link "Delete Merchant"

      expect(current_path).to eq("/merchants")
      expect(page).to_not have_content(doggo_shop.name)
    end
  end

  it "displays merchant stats" do
    pug_store = Merchant.create(name: "Puggotown", address: '123 Pupper Rd.', city: 'Pugville', state: 'VA', zip: 23137)
    dog_food = pug_store.items.create(name: "Foodtime", description: "It's yummy!", price: 10, image: "https://www.zooplus.co.uk/magazine/CACHE_IMAGES/768/content/uploads/2018/01/fotolia_108248133.jpg", inventory: 120)
    soap = pug_store.items.create(name: "Soapy Soap", description: "It's clean!", price: 11, image: "https://i.pinimg.com/originals/a9/bf/77/a9bf779477d6a97519cfe3b8c21dac90.jpg", inventory: 20)
    order = Order.create(name: "Evette", address: "123 street", city: "Denver", state: "CO", zip: 12345)
    order_2 = Order.create(name: "Other Evette", address: "123 other street", city: "New York", state: "NY", zip: 10019)
    order.item_orders.create(item_id: soap.id, order_id: order.id, quantity: 5, total_cost: (soap.price * 5))
    order.item_orders.create(item_id: dog_food.id, order_id: order.id, quantity: 15, total_cost: (dog_food.price * 15))
    order_2.item_orders.create(item_id: dog_food.id, order_id: order.id, quantity: 150, total_cost: (dog_food.price * 150))

    visit "/merchants/#{pug_store.id}"

    expect(page).to have_content(pug_store.item_count)
    expect(page).to have_content(pug_store.average_item_price)
    expect(page).to have_content(pug_store.cities_serviced)
  end
end
