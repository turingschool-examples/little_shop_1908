require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :items_orders}
    it {should have_many(:orders).through(:items_orders)}
  end

  describe "instance methods" do
    it "can return average review rating for an item" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      pull_toy = bike_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 2)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      good_review = chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
      average_review = chain.reviews.create(title: "So-so product", content: "This is okay.", rating: 3)
      negative_review = chain.reviews.create(title: "I don't like this product", content: "This is not a great product. I will not buy it again soon.", rating: 2)
      terrible_review = chain.reviews.create(title: "I hate it", content: "Never buy it again.", rating: 1)

      expect(chain.show_rating).to eq(2)
    end
  end
end
