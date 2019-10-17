require 'rails_helper'

RSpec.describe Cart, type: :model do

  describe '#total_count' do
    it 'can calculate the total number of items' do
      cart = Cart.new({'1' => 2, '2' => 3})

      expect(cart.total_count).to eq(5)
    end
  end

  describe '#add_item' do
    it 'can add an item to contents' do
      cart = Cart.new({'1' => 2, '2' => 3})

      cart.add_item(1)
      cart.add_item(2)
      cart.add_item(3)

      expect(cart.contents).to eq({'1' => 3, '2' => 4, '3' => 1})
    end
  end

  describe '#count_of' do
    it 'returns the count of a specific item' do
      cart = Cart.new({'1' => 2, '2' => 3})

      expect(cart.count_of(1)).to eq(2)
    end
  end

  describe '#subtotal' do
    it 'returns the subtotal of a specific item' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)


      cart = Cart.new({"#{@tire.id}" => 2})

      expect(cart.subtotal(@tire.id)).to eq(200)
    end
  end

  describe '#grand_total' do
    it 'returns the total of all item subtotals' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)


      cart = Cart.new({"#{@tire.id}" => 2, "#{@pull_toy.id}" => 6})

      expect(cart.grand_total).to eq(260)
    end
  end

  describe '#empty_contents' do
    it 'deletes all items from cart' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      cart = Cart.new({"#{@tire.id}" => 2, "#{@pull_toy.id}" => 6})
      cart.empty_contents

      expect(cart.contents).to eq({})

      cart.add_item(@tire.id)

      expect(cart.contents).to eq({"#{@tire.id}" => 1})
    end
  end

  describe '#remove_item' do
    it 'can remove an item from the cart by id' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      cart = Cart.new({"#{@tire.id}" => 2, "#{@pull_toy.id}" => 6})
      cart.remove_item(@pull_toy.id)

      expect(cart.contents).to eq({"#{@tire.id}" => 2})
    end
  end

  describe '#decrease_quantity_of' do
    it 'can decrease the quantity of an item from the cart by id' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      cart = Cart.new({"#{@tire.id}" => 2, "#{@pull_toy.id}" => 6})
      cart.decrease_quantity_of(@pull_toy.id)

      expect(cart.contents).to eq({"#{@tire.id}" => 2, "#{@pull_toy.id}" => 5})
    end
  end

  describe '#decrease_or_remove_item' do
    it 'can decrease quantity of or remove an item depending on item count' do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      cart = Cart.new({"#{@tire.id}" => 2})

      cart.decrease_or_remove_item(@tire.id)
      expect(cart.contents).to eq({"#{@tire.id}" => 1})

      cart.decrease_or_remove_item(@tire.id)
      expect(cart.contents).to eq({})
    end
  end

end
