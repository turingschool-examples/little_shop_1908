require 'rails_helper'

describe Item do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :reviews}
    it { should have_many :item_orders}
    it { should have_many(:orders).through(:item_orders) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of(:price).only_integer }
    it { should validate_presence_of :image }
    it { should validate_numericality_of(:inventory).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "instance methods" do
    before(:each) do
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)
      @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 2)

      @review_1 = @pull_toy.reviews.create(title: "This toy rules", content: "I bought this for my dog and it rules", rating: 5)
      @review_2 = @pull_toy.reviews.create(title: "This toy sucks", content: "My dog hates this toy", rating: 1)
      @review_3 = @pull_toy.reviews.create(title: "Meh", content: "It's blah", rating: 2)
      @review_4 = @pull_toy.reviews.create(title: "Don't buy!", content: "Causes death", rating: 1)
      @review_5 = @pull_toy.reviews.create(title: "Great", content: "Love it", rating: 5)
      @review_6 = @pull_toy.reviews.create(title: "Pretty good", content: "Thumbs up", rating: 4)
    end

    it "avg_rating" do
      expect(@pull_toy.avg_rating).to eq(3)
    end

    it "best_reviews" do
      expect(@pull_toy.best_reviews).to eq([@review_1, @review_5, @review_6])
    end

    it "worst_reviews" do
      expect(@pull_toy.worst_reviews).to eq([@review_2, @review_4, @review_3])
    end

    it "has_been_ordered?" do
      refute(@pull_toy.has_been_ordered?)

      order = Order.create(name: "Evette", address: "123 street", city: "Denver", state: "CO", zip: 12345)
      order.item_orders.create(item_id: @pull_toy.id, order_id: order.id, quantity: 5, total_cost: (@pull_toy.price * 5))

      assert(@pull_toy.has_been_ordered?)
    end

    it "buy item ticks down inventory by 1" do
      expect(@pull_toy.inventory).to eq(2)

      @pull_toy.buy

      expect(@pull_toy.inventory).to eq(1)
    end

    it "restock items" do
      expect(@pull_toy.inventory).to eq(2)
      @pull_toy.buy
      @pull_toy.buy
      expect(@pull_toy.inventory).to eq(0)
      expect(@pull_toy.active?).to eq(false)

      @pull_toy.restock_qty(2)
      @pull_toy.restock
      expect(@pull_toy.inventory).to eq(2)
      expect(@pull_toy.active?).to eq(true)
    end
  end
end
