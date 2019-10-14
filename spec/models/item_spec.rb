require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should allow_value(%w(true false)).for(:active?) } 
  end


  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :reviews }
    it { should have_many :item_orders }
    it { should have_many(:orders).through(:item_orders) }
  end

  describe 'instance methods' do
    describe '#top three reviews' do
      it 'find the top 3 best rated reviews for that item' do
        bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        review_1 = chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
        review_2 = chain.reviews.create(title: "Awesome chain!", content: "This was a great chain! Would buy again.", rating: 5)
        review_3 = chain.reviews.create(title: "Meh", content: "Not the best.", rating: 2)
        review_4 = chain.reviews.create(title: "Okay", content: "Got the job done.", rating: 3)
        review_5 = chain.reviews.create(title: "Pretty Good", content: "Good chain, would probably buy again.", rating: 4)
        review_6 = chain.reviews.create(title: "Best chain EVER!", content: "So amazing, I'm in love.", rating: 5)

        expect(chain.top_three_reviews).to eq([review_2, review_6, review_5])
      end
    end
    describe '#bottom three reviews' do
      it 'find the worst 3 rated reviews for that item' do
        bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        review_1 = chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
        review_2 = chain.reviews.create(title: "Awesome chain!", content: "This was a great chain! Would buy again.", rating: 5)
        review_3 = chain.reviews.create(title: "Meh", content: "Not the best.", rating: 2)
        review_4 = chain.reviews.create(title: "Okay", content: "Got the job done.", rating: 3)
        review_5 = chain.reviews.create(title: "Pretty Good", content: "Good chain, would probably buy again.", rating: 4)
        review_6 = chain.reviews.create(title: "Best chain EVER!", content: "So amazing, I'm in love.", rating: 5)

        expect(chain.bottom_three_reviews).to eq([review_1, review_3, review_4])
      end
    end
    describe '#average rating' do
      it 'returns the average rating for the item' do
        bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        review_1 = chain.reviews.create(title: "Worst chain!", content: "NEVER buy this chain.", rating: 1)
        review_2 = chain.reviews.create(title: "Awesome chain!", content: "This was a great chain! Would buy again.", rating: 5)
        review_3 = chain.reviews.create(title: "Meh", content: "Not the best.", rating: 2)
        review_4 = chain.reviews.create(title: "Okay", content: "Got the job done.", rating: 3)
        review_5 = chain.reviews.create(title: "Pretty Good", content: "Good chain, would probably buy again.", rating: 4)
        review_6 = chain.reviews.create(title: "Best chain EVER!", content: "So amazing, I'm in love.", rating: 5)

        expect(chain.average_rating).to eq(3.33)
      end
    end
    describe '#order_item' do
      it 'returns the item order object for that item and the given order(based on order id)' do
        bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 50.00, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        items = { "#{tire.id}" => 2 }
        cart = Cart.new(items)
        order = Order.create!(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', grand_total: 100.00, creation_date: '10/22/2019')
        item_order = tire.item_orders.create(item_quantity: 2, item_subtotal: 100.00, order_id: order.id)

        expect(tire.order_item(order.id)).to eq(item_order)
      end
    end
  end

end
