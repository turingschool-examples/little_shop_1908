require 'rails_helper'

RSpec.describe Cart do
  before(:each) do
    @items_hash = {'item_1' => 4, 'item_2' => 5, 'item_3' => 3}
    @cart = Cart.new(@items_hash)
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(@cart.contents).to eq({'item_1' => 4, 'item_2' => 5, 'item_3' => 3})
    end
  end

  describe 'instance methods' do
    describe '#add_item' do
      it 'adds an item to the cart contents' do
        cart = Cart.new(Hash.new(0))
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)

        expect(cart.contents).to eq({pull_toy.id.to_s => 1, dog_bone.id.to_s => 1})
      end
    end
    describe '#all_items' do
      it 'returns the item ids in the cart' do
        cart = Cart.new(Hash.new(0))
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)

        expect(cart.all_items).to eq([pull_toy.id.to_s, dog_bone.id.to_s])
      end
    end
    describe '#total_count' do
      it 'can calculate total items' do
        expect(@cart.total_count).to eq(12)
      end
    end
    describe '#count_of' do
      it 'returns the quantity of an item in the cart' do
        cart = Cart.new(Hash.new(0))
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

        cart.add_item(pull_toy.id)
        cart.add_item(pull_toy.id)
        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)

        expect(cart.count_of(pull_toy.id)).to eq(3)
        expect(cart.count_of(dog_bone.id)).to eq(1)
      end
    end
    describe '#subtotal' do
      it 'returns subtotal for an item in the cart' do
        cart = Cart.new(Hash.new(0))
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

        cart.add_item(pull_toy.id)
        cart.add_item(pull_toy.id)
        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)

        expect(cart.subtotal(pull_toy.id, cart.count_of(pull_toy.id))).to eq(30.00)
        expect(cart.subtotal(dog_bone.id, cart.count_of(dog_bone.id))).to eq(21.00)
      end
    end
    describe '#grand_total' do
      it 'returns the total of all items in the cart' do
        cart = Cart.new(Hash.new(0))
        brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
        pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

        cart.add_item(pull_toy.id)
        cart.add_item(pull_toy.id)
        cart.add_item(pull_toy.id)
        cart.add_item(dog_bone.id)


         expect(cart.grand_total).to eq(51.00)
       end
     end
     describe '#remove_item' do
       it 'removes an item from the cart contents' do
         cart = Cart.new(Hash.new(0))
         brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
         pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
         dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

         cart.add_item(pull_toy.id)
         cart.add_item(pull_toy.id)
         cart.add_item(pull_toy.id)
         cart.add_item(dog_bone.id)

         cart.remove_item(pull_toy.id.to_s)
         expect(cart.contents).to eq({dog_bone.id.to_s => 1})
       end
     end
     describe '#increment_item_quantity' do
       it 'adds an additional count to cart for an item' do
         cart = Cart.new(Hash.new(0))
         brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
         pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
         dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

         cart.add_item(pull_toy.id)
         cart.add_item(pull_toy.id)
         cart.add_item(pull_toy.id)
         cart.add_item(dog_bone.id)

         expect(cart.contents).to eq({pull_toy.id.to_s => 3, dog_bone.id.to_s => 1})

         cart.increment_item_quantity(dog_bone.id)

         expect(cart.contents).to eq({pull_toy.id.to_s => 3, dog_bone.id.to_s => 2})
       end
     end
     describe '#decrement_item_quantity' do
       it 'decreases the count of an item in the cart by 1' do
         cart = Cart.new(Hash.new(0))
         brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
         pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
         dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

         cart.add_item(pull_toy.id)
         cart.add_item(pull_toy.id)
         cart.add_item(pull_toy.id)
         cart.add_item(dog_bone.id)

         expect(cart.contents).to eq({pull_toy.id.to_s => 3, dog_bone.id.to_s => 1})

         cart.decrement_item_quantity(pull_toy.id)
         cart.decrement_item_quantity(pull_toy.id)

         expect(cart.contents).to eq({pull_toy.id.to_s => 1, dog_bone.id.to_s => 1})
       end
     end
  end
end
