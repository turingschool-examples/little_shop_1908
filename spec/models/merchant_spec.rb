require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  describe 'instance methods' do
    describe '#average_item_price' do
      it 'gives average price for all items sold by that merchant' do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        shifter = meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

        expect(meg.average_item_price).to eq(110)
      end
    end

    describe '#distinct_cities' do
      it 'returns the cities where this merchant has sold' do
        bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
        tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 50.00, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 25.05, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        shifter = bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 50.00, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 4)
        items = { "#{tire.id}" => 2, "#{chain.id}" => 1, "#{shifter.id}" => 3}
        cart = Cart.new(items)

        toysRus = Merchant.create(name: 'Toys R Us', address: '24 Nostalgia Way', city: 'Atlanta', state: 'GA', zip: "10234")
        toy_1 = toysRus.items.create(name: 'Bear', description: 'fluffy', price: 20.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJgNO8Qet5zTdF_SEP9efG7QXgK5VU05lzvwNPxDcJo8usTfBC&s', inventory: 22)

        order_4 = Order.create(name: 'Mary', address: '730 16th St', city: 'Seattle', state: 'WA', zip: '80902', grand_total: 20.00, creation_date: '10/22/2019') 

        toy_1.item_orders.create(item_quantity: 1, item_subtotal: 20.00, order_id: order_4.id)

        order_1 = Order.create!(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', grand_total: 275.05, creation_date: '10/22/2019')
        tire.item_orders.create(item_quantity: 2, item_subtotal: 100.00, order_id: order_1.id)
        chain.item_orders.create(item_quantity: 1, item_subtotal: 25.05, order_id: order_1.id)
        shifter.item_orders.create(item_quantity: 3, item_subtotal: 150.00, order_id: order_1.id)

        order_2 = Order.create!(name: 'Richy Rich', address: '102 Main St', city: 'Denver', state: 'CO', zip: '80202', grand_total: 275.05, creation_date: '10/22/2019')
        tire.item_orders.create(item_quantity: 2, item_subtotal: 100.00, order_id: order_2.id)
        chain.item_orders.create(item_quantity: 1, item_subtotal: 25.05, order_id: order_2.id)
        shifter.item_orders.create(item_quantity: 3, item_subtotal: 150.00, order_id: order_2.id)

        order_3 = Order.create!(name: 'Richy Rich', address: '102 Main St', city: 'Portland', state: 'Oregon', zip: '30492', grand_total: 275.05, creation_date: '10/22/2019')
        tire.item_orders.create(item_quantity: 2, item_subtotal: 100.00, order_id: order_3.id)
        chain.item_orders.create(item_quantity: 1, item_subtotal: 25.05, order_id: order_3.id)
        shifter.item_orders.create(item_quantity: 3, item_subtotal: 150.00, order_id: order_3.id)

        expect(bike_shop.distinct_cities).to eq(['NY', 'Denver', 'Portland'])
      end
    end
  end



end
