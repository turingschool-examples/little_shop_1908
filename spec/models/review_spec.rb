require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_presence_of :rating }
  end

  describe "relationships" do
    it {should belong_to :item}
  end

  describe "class methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @good_review = @chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
      @average_review = @chain.reviews.create(title: "So-so product", content: "This is okay.", rating: 3)
      @negative_review = @chain.reviews.create(title: "I don't like this product", content: "This is not a great product. I will not buy it again soon.", rating: 2)
      @terrible_review = @chain.reviews.create(title: "I hate it", content: "Never buy it again.", rating: 1)
    end

    it "show average review rating" do
      expect(Review.average_review_rating).to eq(2.75)
    end

    it "show top three ratings" do
      expect(Review.top_three_reviews.length).to eq(3)
    end

    it "show bottom three ratings" do
      expect(Review.bottom_three_reviews.length).to eq(3)
    end
  end
end
