# As a visitor
# When I visit an item's show page from the items index
# I see a link or button to add this item to my cart
# And I click this link or button
# I am returned to the item index page
# I see a flash message indicating the item has been added to my cart
# The cart indicator in the navigation bar increments my cart count
require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({
        1 => 2,
        2 => 3
      })
      expect(cart.total_count).to eq(5)
    end

    describe "#add_item" do
    it "adds a item to its contents" do
      cart = Cart.new({
        '1' => 2,
        '2' => 3
      })
      cart.add_item(1)
      cart.add_item(2)

      expect(cart.contents).to eq({'1' => 3, '2' => 4})
      end
    end

    describe "#count_of" do
      it "returns the count of all items in the cart" do
        cart = Cart.new({})

        expect(cart.count_of(5)).to eq(0)
      end
    end

    describe "#total" do
      it 'provides the a total amount for all items in the cart' do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
        cart = Cart.new({})
        cart.add_item(tire.id)
        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)

        expect(cart.total).to eq(131)
      end
    end
    describe "#item_quantity" do
      it 'returns hash with item object and quantity' do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
        cart = Cart.new({})
        cart.add_item(tire.id)
        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)

        expected = {tire => 1, pull_toy => 1, dog_bone => 1 }

        expect(cart.item_quantity).to eq(expected)
      end
    end
  end
end
